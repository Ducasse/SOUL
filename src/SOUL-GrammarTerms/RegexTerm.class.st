Class {
	#name : #RegexTerm,
	#superclass : #MessageTerm,
	#instVars : [
		'goals',
		'generatedGoals',
		'identifier',
		'initialGoal',
		'endGoal',
		'failGoal',
		'generatedClauses',
		'edgeTerm',
		'startWorld',
		'endWorld',
		'variablesVar',
		'resultVar',
		'pathVar',
		'versionTrans'
	],
	#classInstVars : [
		'nrGeneratedGoals',
		'keywords',
		'nrRegexTerms',
		'generatedClauses'
	],
	#category : 'SOUL-GrammarTerms'
}

{ #category : #private }
RegexTerm class >> addRegexTerm [
	
	nrRegexTerms := self nrRegexTerms + 1.
	^nrRegexTerms
]

{ #category : #'clause generation' }
RegexTerm class >> generateRule: aString definitionRepository: aRepository [
	
	| newRule |
	newRule := (SoulFactory current makeParser
		parse: aString
		onError: [:a :b | self error: 'parse error in generated regexrule'])
		clauses first.
	generatedClauses add: newRule.
	^newRule
]

{ #category : #'clause generation' }
RegexTerm class >> generatedClauses [
	
	^generatedClauses
]

{ #category : #private }
RegexTerm class >> incNrGeneratedGoals [
	
	nrGeneratedGoals := nrGeneratedGoals + 1
]

{ #category : #private }
RegexTerm class >> keywords [
	
	keywords
		ifNil:
			[keywords := Dictionary new.
			keywords at: #manyOf put: #processManyOf:remainingConditions:.
			keywords at: #or put: #processOr:remainingConditions:.	"keywords at: #not put: #processNot:remainingConditions: ."
	"keywords at: #and put: #processAnd:remainingConditions: ."

			keywords at: #notSoManyOf put: #processLazyManyOf:remainingConditions:.
			keywords at: #plus put: #processPlus].
	^keywords
]

{ #category : #'instance creation' }
RegexTerm class >> newFromMessageTerm: aMessageTerm withGoals: goals [
	
	| term |
	term := RegexTerm
		functor: aMessageTerm functor
		termSequence: aMessageTerm termSequence
		astLink: aMessageTerm astLink.
	term validateRegexTerms.
	term goals: goals.
	^term
]

{ #category : #private }
RegexTerm class >> nrGeneratedGoals [
	
	nrGeneratedGoals ifNil: [nrGeneratedGoals := 0].
	^nrGeneratedGoals
]

{ #category : #private }
RegexTerm class >> nrRegexTerms [
	
	nrRegexTerms ifNil: [nrRegexTerms := 0].
	^nrRegexTerms
]

{ #category : #'clause generation' }
RegexTerm class >> resetGeneratedClauses [
	
	generatedClauses := OrderedCollection new
]

{ #category : #accessing }
RegexTerm >> additionalClausesForDefinitionRepository [
	
	^generatedClauses
]

{ #category : #private }
RegexTerm >> allAfter: anObject in: aCollection [
	
	| startIndex |
	startIndex := aCollection indexOf: anObject.
	^aCollection
		copyFrom: startIndex + 1
		to: aCollection size
]

{ #category : #private }
RegexTerm >> allBefore: anObject in: aCollection [
	
	^aCollection copyUpTo: anObject
]

{ #category : #private }
RegexTerm >> connect: from to: to class: aRegexTransitionClass [
	
	^from connectTo: to transition: aRegexTransitionClass
]

{ #category : #private }
RegexTerm >> detectRegexPrimitive: aTermCollection [
	
	| termFunctor |
	aTermCollection
		do:
			[:term | 
			term isCompoundTerm
				ifTrue:
					[termFunctor := term functor name.
					(RegexTerm keywords
						at: termFunctor
						ifAbsent: [nil]) ifNotNil: [^term]]].
	^nil
]

{ #category : #converting }
RegexTerm >> fixTermMagic [
	"in the hope of making our regexterm automagically work with the rest we are correcting our functor and termsequence,
	as SOUL will automagically run the correct query, generate a rainbow and some unicorns. If not all hell breaks lose
	and I will be a sad bunny"

	
	| collection startState endState path |
	collection := OrderedCollection with: (self getResultVariable).
	startState := self getStartWorld.
	endState := self getEndWorld.
	path := self getPathVariable.
	self prepareForModifyingTermsequence.
	
	collection add: startState.
	collection add: endState.
	collection add: path.
	termsequence := TermSequence terms: collection.
	self isExistential
		ifTrue:
			[functor := MessageFunctor
				name: 'somepath' , self identifier asString , ':endWorld:path:']
		ifFalse:
			[self isUniversal
				ifTrue:
					[functor := MessageFunctor
						name: 'allpaths' , self identifier asString , ':endWorld:']
				ifFalse:
					[self error:
							'regexterm without a universal (a) or existentional (e) quantifier']]
]

{ #category : #converting }
RegexTerm >> generateClauses [
	
	RegexTerm resetGeneratedClauses.
	generatedGoals
		do:
			[:goal | goal generateTransitions: self term: (self getEdgeTerm) definitionRepository: nil].
	self isExistential ifTrue: [self generateExistential: nil].
	self isUniversal ifTrue: [self generateUniversal: nil].
	generatedClauses := RegexTerm generatedClauses
]

{ #category : #private }
RegexTerm >> generateExistential: aDefinitionRepository [
	
	| nproduct nreachBase nreachRecur somePaths failnpattern coll |
	nproduct := 'nproduct' , self identifier asString ,
			'(?phi, ?n1, ?a1, ?n2, ?a2, ?current, ?next, ?processedPath, ?differenceVariable, ?restPath, ?newDifferenceVariable, ?newRestPath) if ' , 
			'npattern' , self identifier asString ,
			'(?phi, ?a1, ?a2, ?current, ?next, ?n1, ?n2, ?processedPath, ?differenceVariable, ?restPath, ?newDifferenceVariable, ?newRestPath)'.
	failnpattern := 'npattern' , self identifier asString ,
			'(?phi, ?a1, ?a2, ?n1, ?n2, ?current, ?next, ?processedPath, ?differenceVariable, ?restPath, ?newDifferenceVariable, ?newRestPath) if !, [ false ]'.
	nreachBase := 'nreach' , self identifier asString ,
			'(?phi, ?n1,?p1, ?n1, ?p1, ?current, ?next, ?processedPath, ?differenceVariable, <>) if [true]'.
	nreachRecur := 'nreach' , self identifier asString ,
			'(?phi, ?n1,?p1, ?n2, ?p2, ?current, ?next, ?processedPath, ?differenceVariable, ?restPath) if ' , 
			'nproduct' , self identifier asString ,
			'(?phi, ?n1, ?p1, ?na, ?pa, ?current, ?next, ?processedPath, ?differenceVariable, ?restPath, ?newDifferenceVariable, ?newRestPath),' , 
			'nreach' , self identifier asString , '(?phi, ?na, ?pa, ?n2, ?p2, ?next, ?neext, ?processedPath, ?newDifferenceVariable, ?newRestPath)'.
	somePaths := '?phi somepath' , self identifier asString ,
			': ?startWorld endWorld: ?endWorld path: ?path if ' , 
			'nreach', self identifier asString , 
			'(?phi, ?startWorld,' , initialGoal goalId asString , ' , ?endWorld,' , 
			endGoal goalId asString, ', ?startWorld, ?next,', 
			'?differenceVariable, ?differenceVariable, ?path)'.
	coll := OrderedCollection with: nproduct with: nreachBase with:
			nreachRecur with: somePaths.
	coll add: failnpattern.
	coll
		do:
			[:rule | RegexTerm generateRule: rule definitionRepository: aDefinitionRepository]
]

{ #category : #private }
RegexTerm >> generateFailGoal [
	
	| sequence |
	failGoal
		ifNil:
			[sequence := (SoulFactory current makeParser
				parse: ' if [ false ]'
				onError: [:a :b | self error: 'parse error in generated regexrule'])
				condition terms.
			failGoal := self generateGoal: sequence].
	^failGoal
]

{ #category : #private }
RegexTerm >> generateGoal: aCollection [
	
	| generated |
	generated := RegexGoal
		newWith: aCollection
		id: RegexTerm nrGeneratedGoals
		variables: (self getVariables).
	generatedGoals add: generated.
	RegexTerm incNrGeneratedGoals.
	^generated
]

{ #category : #private }
RegexTerm >> generateGoals: aCollection [
	"returns a collection existing out of collections with newly added goals"

	
	| primitive allBefore allAfter newBefores newAfters first last |
	aCollection isEmpty ifTrue: [^nil].
	primitive := self detectRegexPrimitive: aCollection.
	primitive isNil
		ifTrue:
			["no more primitives to process, so we just create a goal"

			^self processCollection: aCollection]
		ifFalse:
			[allBefore := self allBefore: primitive in: aCollection.
			allAfter := self allAfter: primitive in: aCollection.
			newBefores := nil.
			newAfters := nil.
			allBefore isEmpty
				ifFalse: [newBefores := self processCollection: allBefore].
			newAfters := self
				perform: (RegexTerm keywords at: primitive functor smalltalkValue)
				withArguments: (Array with: primitive with: allAfter).
			newBefores isNil
				ifFalse:
					[first := newBefores at: 1.
					last := newBefores at: 2.
					newAfters isNil
						ifFalse:
							[self
								connect: last
								to: (newAfters at: 1)
								class: RegexTransition]].
			newBefores isNil ifTrue: [first := newAfters at: 1].
			last := newAfters at: 2].
	^Array with: first with: last
]

{ #category : #converting }
RegexTerm >> generateStates [
	
	| firstlast end |
	firstlast := self generateGoals: goals termSequence terms.
	initialGoal := firstlast at: 1.
	end := firstlast at: 2.
	endGoal := self generateGoal: OrderedCollection new.
	self connect: end to: endGoal class: RegexEndTransition.
	self fixTermMagic.
	self generateClauses
]

{ #category : #private }
RegexTerm >> generateUniversal: aDefinitionRepository [
	
	| allPaths nproduct nreachBase nreachRecur failnpattern coll |
	self generateExistential: aDefinitionRepository.
	nproduct := 'nproductUniversal' , self identifier asString ,
			'(?phi, ?n1, ?a1, ?n2, ?a2) if ' , 'npatternUniversal'
		, self identifier asString , '(?phi, ?a1, ?a2, ?current, ?n1, ?n2)'.
	failnpattern := 'npatternUniversal' , self identifier asString ,
			'(?phi, ?a1, ?a2, ?current, ?n1, ?n2) if !, [ false ]'.
	nreachBase := 'nreachUniversal' , self identifier asString ,
			'(?phi, ?n1,?p1, ?n1, ?p1) if [true]'.
	nreachRecur := 'nreachUniversal' , self identifier asString ,
			'(?phi, ?n1,?p1, ?n2, ?p2) if ' , 'nproductUniversal'
		, self identifier asString , '(?phi, ?n1, ?p1, ?na, ?pa),' ,
			'nreachUniversal' , self identifier asString ,
			'(?phi, ?na, ?pa, ?n2, ?p2)'.
	allPaths := '?phi allpaths' , self identifier asString ,
			': ?startWorld endWorld: ?endWorld if ' , '?phi somepath'
		, self identifier asString , ': ?startWorld endWorld: ?endWorld,' ,
			'nreachUniversal' , self identifier asString , '(?phi, ?startWorld,'
		, initialGoal goalId asString , ' , ?endWorld,' , endGoal goalId asString
		, ')'.
	coll := OrderedCollection with: nproduct with: nreachBase with:
			nreachRecur with: allPaths.
	coll add: failnpattern.
	coll
		do:
			[:rule | RegexTerm generateRule: rule definitionRepository: aDefinitionRepository]
]

{ #category : #private }
RegexTerm >> getEdgeTerm [
	"I N C E P T I O N"
	edgeTerm ifNil: [
		edgeTerm := self termSequence terms first termSequence terms first
	].
	^edgeTerm.
]

{ #category : #private }
RegexTerm >> getEndWorld [
	"I N C E P T I O N"
	endWorld ifNil: [
		endWorld := self termSequence terms first termSequence terms at: 3	
	].
	^endWorld.
	
	
]

{ #category : #private }
RegexTerm >> getPathVariable [ 
	"I N C E P T I O N"
	pathVar ifNil: [ 
		pathVar := self termSequence terms first termSequence terms at: 5
	].
	^pathVar.
]

{ #category : #private }
RegexTerm >> getResultVariable [
	resultVar ifNil: [
		resultVar := self getVariables.		
	].
	^resultVar.

]

{ #category : #private }
RegexTerm >> getStartWorld [
	"I N C E P T I O N"
	startWorld ifNil: [
		startWorld := self termSequence terms first termSequence terms at: 2.	
	].
	^startWorld
]

{ #category : #private }
RegexTerm >> getVariables [
	"I N C E P T I O N"
	variablesVar ifNil: [
		variablesVar :=	self termSequence terms first termSequence terms at: 4
	].
	^variablesVar.
]

{ #category : #accessing }
RegexTerm >> goals: anObject [
	
	goals := anObject
]

{ #category : #accessing }
RegexTerm >> identifier [
	
	^identifier
]

{ #category : #'initialize-release' }
RegexTerm >> initialize [
	
	super initialize.
	identifier := RegexTerm addRegexTerm.
	generatedGoals := OrderedCollection new
]

{ #category : #testing }
RegexTerm >> isExistential [
	
	^goals functor name = #e
]

{ #category : #testing }
RegexTerm >> isUniversal [
	
	^goals functor name = #a
]

{ #category : #private }
RegexTerm >> prepareForModifyingTermsequence [
	"we save all the variables before modifying our own termsequence"
	self getEdgeTerm.
	self getEndWorld.
	self getPathVariable.
	self getResultVariable.
	self getStartWorld.
	self getVariables.
]

{ #category : #printing }
RegexTerm >> prettyPrintOn: aStream scope: id [
	
	self printOn: aStream
]

{ #category : #printing }
RegexTerm >> printOn: aStream [
	goals printAsKeywordArgOn: aStream.
	aStream write: ' matches: graph('.
	(self getEdgeTerm) printOn: aStream.
	aStream write: ', '.
	(self getStartWorld) printOn: aStream.
	aStream write: ', '.
	(self getEndWorld) printOn: aStream.
	aStream write: ', '.
	(self getVariables) printOn: aStream.
	aStream write: ', '.
	(self getPathVariable) printOn: aStream.
	aStream write: ')'
]

{ #category : #private }
RegexTerm >> processCollection: aCollection [
	
	| first prev curr |
	prev := self generateGoal: (OrderedCollection with: aCollection first).
	first := prev.
	(aCollection allButFirst: 1)
		do:
			[:term | 
			curr := self generateGoal: (OrderedCollection with: term).
			self connect: prev to: curr class: RegexTransition.
			prev := curr].
	^Array with: first with: prev
]

{ #category : #private }
RegexTerm >> processLazyManyOf: manyTerm remainingConditions: aCollection [
	
	| firstLast first last regexLast remainingGoals |
	firstLast := self generateGoals: manyTerm termSequence terms.
	firstLast ifNil: [self error: 'manyOf with empty arguments'].
	first := firstLast at: 1.
	last := firstLast at: 2.
	regexLast := last.
	remainingGoals := self generateGoals: aCollection.
	remainingGoals isNil
		ifFalse:
			[self
				connect: first
				to: (remainingGoals at: 1)
				class: RegexEpsilonTransition.
			last := remainingGoals at: 2]
		ifTrue: [last := first].
	self connect: regexLast to: first class: RegexTransition.
	^Array with: first with: last
]

{ #category : #private }
RegexTerm >> processManyOf: manyTerm remainingConditions: aCollection [
	
	| firstLast first last remainingGoals |
	firstLast := self generateGoals: manyTerm termSequence terms.
	firstLast ifNil: [self error: 'manyOf with empty arguments'].
	first := firstLast at: 1.
	last := firstLast at: 2.
	self connect: last to: first class: RegexTransition.
	remainingGoals := self generateGoals: aCollection.
	remainingGoals isNil
		ifFalse:
			[self
				connect: first
				to: (remainingGoals at: 1)
				class: RegexEpsilonTransition.
			last := remainingGoals at: 2]
		ifTrue: [last := first].
	^Array with: first with: last
]

{ #category : #private }
RegexTerm >> processNot: notTerm remainingConditions: aCollection [
	
	| end notGoal newGoals remainingGoals fail |
	newGoals := self generateGoal: notTerm termSequence terms.
	newGoals ifNil: [self error: 'not term without any goals'].
	notGoal := self generateGoal: OrderedCollection new.
	self
		connect: notGoal
		to: (newGoals at: 1)
		class: RegexEpsilonTransition.
	remainingGoals := self generateGoals: aCollection.
	fail := self generateFailGoal.	"if newGoals succeeds we have to fail"

	self
		connect: (newGoals at: 2)
		to: fail
		class: RegexCuttedEpsilonTransition.
	remainingGoals isNil
		ifFalse:
			[self
				connect: notGoal
				to: (remainingGoals at: 1)
				class: RegexCuttedEpsilonTransition.
			end := remainingGoals at: 2]
		ifTrue:
			["we have to create a success-goal"

			end := self
				generateGoal:
					(SoulFactory current makeParser
						parse: 'if [ true ]'
						onError: [:a :b | self error: 'parse error in generated regexrule'])
						condition terms.
			self connect: notGoal to: end class: RegexCuttedEpsilonTransition].
	^Array with: notGoal with: end
]

{ #category : #private }
RegexTerm >> processOr: orTerm remainingConditions: aCollection [
	
	| start end newGoals remainingGoals |
	newGoals := OrderedCollection new.
	orTerm termSequence terms
		do:
			[:termSequence | newGoals add: (self generateGoals: termSequence terms)].
	start := self generateGoal: OrderedCollection new.
	end := self generateGoal: OrderedCollection new.
	newGoals
		do:
			[:firstLast | 
			self
				connect: start
				to: (firstLast at: 1)
				class: RegexEpsilonTransition.
			self
				connect: (firstLast at: 2)
				to: end
				class: RegexEpsilonTransition].
	remainingGoals := self generateGoals: aCollection.
	remainingGoals isNil
		ifFalse:
			[self
				connect: end
				to: (remainingGoals at: 1)
				class: RegexTransition.
			end := remainingGoals at: 2].
	^Array with: start with: end
]

{ #category : #private }
RegexTerm >> processPlus: plusTerm remainingConditions: aCollection [
	
	| firstLast first last remainingGoals |
	firstLast := self generateGoals: plusTerm termSequence terms.
	firstLast ifNil: [self error: 'plusTerm with empty arguments'].
	remainingGoals := self processManyOf: plusTerm remainingConditions:
			aCollection.
	first := firstLast at: 1.
	last := firstLast at: 2.
	remainingGoals isNil
		ifFalse:
			[self
				connect: (firstLast at: 2)
				to: (remainingGoals at: 1)
				class: RegexTransition.
			last := remainingGoals at: 2].
	^Array with: first with: last
]

{ #category : #private }
RegexTerm >> processTimes: timesTerm remainingConditions: aCollection [
	
	| times firstLast first last remainingGoals terms timesTerms |
	terms := timesTerm termSequence terms.
	terms size < 2
		ifTrue:
			[self error: 'times term requires at least 2 arguments, times and goals'].
	times := (terms at: 1) smalltalkValue.
	timesTerms := terms allButFirst: 1.
	firstLast := self generateGoals: timesTerms.
	first := firstLast at: 1.
	last := firstLast at: 2.
	2
		to: times
		do:
			[:i | 
			| generated |
			generated := self generateGoals: timesTerms.
			self
				connect: last
				to: (generated at: 1)
				class: RegexTransition.
			last := generated at: 2].
	remainingGoals := self generateGoals: aCollection.
	remainingGoals isNil
		ifFalse:
			[self
				connect: last
				to: (remainingGoals at: 1)
				class: RegexTransition.
			last := remainingGoals at: 2].
	^Array with: first with: last
]

{ #category : #'initialize-release' }
RegexTerm >> validateRegexTerms [
	|size|
	size := self termSequence terms first termSequence terms size.
	((5 to: 5) includes: size)
		ifFalse:
			[self error:
					'goalTerm needs to have 5 arguments: transition, startworld, endworld, variables and a pathvariable'].
]
