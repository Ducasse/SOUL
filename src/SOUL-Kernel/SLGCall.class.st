Class {
	#name : #SLGCall,
	#superclass : #Object,
	#instVars : [
		'callTerm',
		'waitingNodes',
		'cid',
		'answers',
		'evaluator',
		'plink',
		'nlink',
		'comp',
		'dfn',
		'negativeWaitingNodes',
		'slgQuery',
		'continuationQuery',
		'negativeQuery'
	],
	#classInstVars : [
		'continuationQuery',
		'negativeQuery'
	],
	#category : 'SOUL-Kernel'
}

{ #category : #'instance creation' }
SLGCall class >> call: aSoulTerm cid: anInteger [
	
	^self new call: aSoulTerm cid: anInteger
]

{ #category : #accessing }
SLGCall class >> continuationQuery [
	
	^continuationQuery
]

{ #category : #accessing }
SLGCall class >> continuationQuery: anObject [
	
	continuationQuery := anObject
]

{ #category : #'initialize-release' }
SLGCall class >> initializeQueries [
	
	| parseBlock |
	parseBlock := [:aQueryText | 
	SoulFactory current makeParser
		parse: aQueryText
		onError:
			[:text :pos | self error: 'Parser error: ' , text , 'at: ' , pos asString]].
	continuationQuery := parseBlock value:
			'if  ?Cont@(<?Id , ?Vars, ?Answer ,?Delayed>)'.
	negativeQuery := parseBlock value: 'if ?Cont@(<?Id, ?Vars, ?Delayed>)'
]

{ #category : #accessing }
SLGCall class >> negativeQuery [
	
	^negativeQuery
]

{ #category : #accessing }
SLGCall class >> negativeQuery: anObject [
	
	negativeQuery := anObject
]

{ #category : #accessing }
SLGCall >> addAnswer: anAnswerTerm with: delayed [
	"Add an answer for the call"

	
	answers
		add:
			(Array
				with: anAnswerTerm
				with: delayed copy)
]

{ #category : #accessing }
SLGCall >> addNegativeWaitingId: anId variables: someVars delay: delay continuation: continuationPredicate [
	"Add a negative waiting node"

	
	| positiveDelayed negativeDelayed |
	positiveDelayed := delay at: 1.
	negativeDelayed := delay at: 2.
	negativeWaitingNodes
		add:
			(WaitingNode callId: anId variables: someVars delayedPrimitives:
					positiveDelayed delayedNegatedPrimitives: negativeDelayed
				continuation: continuationPredicate)
]

{ #category : #private }
SLGCall >> addToStack [
	
	^self addToStack: false
]

{ #category : #private }
SLGCall >> addToStack: aBoolean [
	
	| newdfn |
	newdfn := SoulFactory addCallToStack: self.
	aBoolean
		ifTrue:
			["dfn notNil ifTrue: [
			this is probably a mistake, remove later when everything works
			^self halt.
		]."

			dfn := newdfn.
			plink := dfn]
]

{ #category : #accessing }
SLGCall >> addWaitingId: anId variables: someVars delay: delay continuation: continuationPredicate [
	"Add a waiting node"

	
	| positiveDelayed negativeDelayed |
	positiveDelayed := delay at: 1.
	negativeDelayed := delay at: 2.
	waitingNodes
		add:
			(WaitingNode callId: anId variables: someVars delayedPrimitives:
					positiveDelayed delayedNegatedPrimitives: negativeDelayed
				continuation: continuationPredicate)
]

{ #category : #accessing }
SLGCall >> answers [
	
	^self answersShowMuffled: false
]

{ #category : #accessing }
SLGCall >> answersShowMuffled: aBoolean [
	
	| delayed accept |
	^(answers
		reject:
			[:answer | 
			delayed := answer at: 2.
			accept := (delayed at: 1) isEmpty and: [(delayed at: 2) isEmpty].
			aBoolean
				ifTrue:
					[accept
						ifFalse:
							[Transcript
								show:
									'muffling answer: ' , (answer at: 1) asString , ' ' , delayed asString.
							Transcript cr]].
			accept not]) collect: [:answer | answer at: 1]
]

{ #category : #'initialize-release' }
SLGCall >> call: aCallTerm cid: anInteger [
	
	callTerm := aCallTerm.
	cid := anInteger.
	answers := OrderedCollection new.
	waitingNodes := OrderedCollection new.
	negativeWaitingNodes := OrderedCollection new.
	nlink := Float infinity.
	comp := false.	"slgQuery := parseBlock value: 'if slg' , (callTerm asString allButLast: 1) , ',' , cid asString , ')'."

	continuationQuery := SLGCall continuationQuery.
	negativeQuery := SLGCall negativeQuery
]

{ #category : #accessing }
SLGCall >> cid [
	
	^cid
]

{ #category : #accessing }
SLGCall >> comp [
	
	^comp
]

{ #category : #accessing }
SLGCall >> comp: aBoolean [
	
	comp := aBoolean
]

{ #category : #testing }
SLGCall >> dependsOnCallDeepBelow [
	
	^self plink = self dfn
		and: [self dfn <= self nlink and: [self hasMaxNLink not]]
]

{ #category : #accessing }
SLGCall >> dfn [
	
	^dfn
]

{ #category : #private }
SLGCall >> equivalenceStringFor: aTerm [
	
	| string last first intervals |
	string := aTerm asString.
	intervals := OrderedCollection new.
	last := 0.
	[first := string
		findFirst: [:char | char = $?]
		startingAt: last + 1.
	first ~= 0]
		whileTrue:
			[last := (string
				findFirst: [:char | char isAlphaNumeric not]
				startingAt: first + 1) - 1.
			last < 0 ifTrue: [last := string size].
			intervals add: (first + 1 to: last)].
	intervals do: [:interval | interval do: [:i | string at: i put: $*]].
	^string copyWithout: $*
]

{ #category : #evaluation }
SLGCall >> evaluate [
	"Start the evaluation of the call"

	
	| name list associations fun |
	self addToStack: true.	"evaluator := Soul.Evaluator
		eval: 'if slg' , (callTerm asString allButLast: 1) , ',' , cid asString , ')'
		in: callTerm definitionRepository."

	fun := callTerm functor.	"party in the parleh"

	fun isMessageFunctor
		ifTrue: [name := '#id:' , 'slg' , fun smalltalkValue asString]
		ifFalse: [name := 'slg' , fun smalltalkValue asString].
	list := ListTerm termSequence: callTerm termSequence.
	associations := OrderedCollection
		with: #Arguments -> list
		with: #Id -> cid.
	evaluator := SoulFactory current evaluatorForLogicQuery
		eval: 'if ' , name , '@(<?Id | ?Arguments >)'
		in: callTerm definitionRepository
		withAssociations: associations.
	evaluator allResults
]

{ #category : #evaluation }
SLGCall >> evaluateAnswersWith: aContinuation id: anId vars: vars delay: delay [
	
	| answerevaluator delayed associations positive negative |
	"Evaluate the answers with a waitingNode"

	positive := delay at: 1.
	negative := delay at: 2.
	delayed := positive copy.
	answers copy
		do:
			[:anAnswer | 
			(positive isEmpty and: [negative isEmpty])
				ifFalse: [delayed add: (anAnswer at: 1)].
			associations := OrderedCollection
				with: #Delayed -> (Array with: delayed with: negative)
				with: #Cont -> aContinuation
				with: #Vars -> vars
				with: #Answer -> (anAnswer at: 1).
			associations add: #Id -> anId.
			answerevaluator := SoulFactory current evaluatorForLogicQuery
				evalQuery: (self prepareQuery: continuationQuery)
				in: callTerm definitionRepository
				withAssociations: associations.
			answerevaluator allResults]
]

{ #category : #evaluation }
SLGCall >> evaluateNegativeWaitingNode: aWaitingNode [
	"boolean indicates undefined"

	
	| id continuation waitingevaluator vars associations newDelayed onlyDelayedAnswers hasNoAnswer |
	onlyDelayedAnswers := (answers
		contains:
			[:answer | 
			| delayed pos neg |
			delayed := answer at: 2.
			pos := delayed at: 1.
			neg := delayed at: 2.
			pos isEmpty and: [neg isEmpty]]) not.
	hasNoAnswer := answers isEmpty or: [onlyDelayedAnswers].
	hasNoAnswer
		ifTrue:
			[id := aWaitingNode callId.
			continuation := aWaitingNode continuation.
			vars := aWaitingNode variables.
			newDelayed := aWaitingNode delayedNegatedPrimitives.
			(answers isEmpty not and: [onlyDelayedAnswers])
				ifTrue:
					[newDelayed
						detect: [:x | x = self]
						ifNone: [newDelayed add: self]].
			associations := OrderedCollection
				with:
					#Delayed
						->
							(Array
								with: aWaitingNode delayedPrimitives
								with: newDelayed)
				with: #Cont -> continuation
				with: #Id -> id
				with: #Vars -> vars.
			waitingevaluator := SoulFactory current evaluatorForLogicQuery
				evalQuery: (self prepareQuery: negativeQuery)
				in: callTerm definitionRepository
				withAssociations: associations.
			waitingevaluator allResults]
]

{ #category : #evaluation }
SLGCall >> evaluateNegativeWaitingNodes: aBoolean deleteNodes: anotherBoolean [
	"aBoolean indicates undefined"

	
	| id continuation waitingevaluator vars associations newDelayed onlyDelayedAnswers hasNoAnswer negNodes |
	onlyDelayedAnswers := (answers
		noneSatisfy:
			[:answer | 
			| delayed pos neg |
			delayed := answer at: 2.
			pos := delayed at: 1.
			neg := delayed at: 2.
			pos isEmpty and: [neg isEmpty]]).
	hasNoAnswer := answers isEmpty or: [onlyDelayedAnswers].
	hasNoAnswer
		ifTrue:
			[negNodes := negativeWaitingNodes.
			anotherBoolean ifTrue: [negativeWaitingNodes := OrderedCollection new].
			negNodes
				do:
					[:aWaitingNode | 
					id := aWaitingNode callId.
					continuation := aWaitingNode continuation.
					vars := aWaitingNode variables.
					newDelayed := aWaitingNode delayedNegatedPrimitives.
					(aBoolean or: [answers isEmpty not and: [onlyDelayedAnswers]])
						ifTrue:
							[newDelayed
								detect: [:x | x = self]
								ifNone: [newDelayed add: self]].
					associations := OrderedCollection
						with:
							#Delayed
								->
									(Array
										with: aWaitingNode delayedPrimitives
										with: newDelayed)
						with: #Cont -> continuation
						with: #Id -> id
						with: #Vars -> vars.
					waitingevaluator := SoulFactory current evaluatorForLogicQuery
						evalQuery: (Query condition: negativeQuery condition copy)
						in: callTerm definitionRepository
						withAssociations: associations.
					waitingevaluator allResults]]
		ifFalse:
			["negativeWaitingNodes isEmpty ifFalse: [
			^self halt: 'nodes should have been removed when answer was computed'.
		]."

			negativeWaitingNodes := OrderedCollection new]
]

{ #category : #evaluation }
SLGCall >> evaluateWaitingNodesWithAnswer: aTerm using: delayed [
	
	| id continuation waitingevaluator vars associations newDelayed positive negative hasNoDelayed query |
	positive := delayed at: 1.
	negative := delayed at: 2.
	hasNoDelayed := positive isEmpty and: [negative isEmpty].
	hasNoDelayed
		ifTrue:
			["we have a real answer without waitingnodes. Any negative waiting node must fail"

			negativeWaitingNodes := OrderedCollection new].
	waitingNodes
		do:
			[:aWaitingNode | 
			id := aWaitingNode callId.
			continuation := aWaitingNode continuation.
			vars := aWaitingNode variables.
			newDelayed := aWaitingNode delayedPrimitives.
			hasNoDelayed ifFalse: [newDelayed add: aTerm].
			associations := OrderedCollection
				with:
					#Delayed
						->
							(Array
								with: newDelayed
								with: aWaitingNode delayedNegatedPrimitives)
				with: #Cont -> continuation
				with: #Vars -> vars
				with: #Answer -> aTerm.
			associations add: #Id -> id.	"waitingevaluator := Soul.Evaluator
			eval: ('if ' , (continuation asString, '(' , id asString , ',', vars asString, ',', aTerm asString ,', ?D', ')' )) asString
			in: callTerm definitionRepository
			withAssociations: associations."

			query := continuationQuery accept: CopyingVisitor new.
			waitingevaluator := SoulFactory current evaluatorForLogicQuery
				evalQuery: query
				in: callTerm definitionRepository
				withAssociations: associations.
			waitingevaluator allResults]
]

{ #category : #testing }
SLGCall >> hasMaxNLink [
	"Checks if this has the maximum negative link"

	
	^nlink == Float infinity
]

{ #category : #testing }
SLGCall >> includesAnswer: anAnswerTerm using: delayed [
	"Do we already include the answer?"

	
	| pos neg possibleAnswers |
	pos := ((delayed at: 1) collect: [:d | d cid]) sort.
	neg := ((delayed at: 2) collect: [:d | d cid]) sort.
	possibleAnswers := answers
		select: [:a | (a at: 1) isSLGEquivalentTo: anAnswerTerm].	"we now have all the answers, we now have to check if this new answer has the same delayed variables"

	possibleAnswers
		detect:
			[:a | 
			| del |
			del := a at: 2.
			((del at: 1) collect: [:d | d cid]) sort = pos
				and: [((del at: 2) collect: [:d | d cid]) sort = neg]]
		ifNone: [^false].
	^true
]

{ #category : #testing }
SLGCall >> isCompletelyEvaluated [
	^self dfn = self plink and: [self hasMaxNLink]
]

{ #category : #testing }
SLGCall >> isNew [
	"Used to detect if we are a newly created call"

	
	^evaluator == nil
]

{ #category : #testing }
SLGCall >> isSLGEquivalentTo: aCallTerm [
	^aCallTerm isSLGEquivalentTo: callTerm
]

{ #category : #accessing }
SLGCall >> nlink [
	
	^nlink
]

{ #category : #accessing }
SLGCall >> nlink: aNumber [
	
	nlink := aNumber
]

{ #category : #accessing }
SLGCall >> nlinkToMax [
	
	nlink := Float infinity
]

{ #category : #accessing }
SLGCall >> plink [
	
	^plink
]

{ #category : #accessing }
SLGCall >> plink: aNumber [
	
	plink := aNumber
]

{ #category : #private }
SLGCall >> prepareQuery: aQuery [
	"(Query condition: continuationQuery condition copy)"

	
	^aQuery accept: CopyingVisitor new
]

{ #category : #printing }
SLGCall >> printOn: aStream [
	
	| stringRepresentation |
	stringRepresentation := callTerm asString.
	aStream write: stringRepresentation
]

{ #category : #private }
SLGCall >> removeWaitingNodes [
	
	waitingNodes removeAll
]

{ #category : #accessing }
SLGCall >> setMinNLink: anInteger [
	
	anInteger == Float infinity ifFalse: [nlink := nlink min: anInteger].
	^nlink
]

{ #category : #accessing }
SLGCall >> setMinPLink: anInteger [
	
	anInteger == Float infinity ifFalse: [plink := plink min: anInteger].
	^plink
]

{ #category : #private }
SLGCall >> simplifyAnswers: anSLGCall isNegated: aBoolean [
	
	| delayed positive negative |
	answers copy
		do:
			[:answer | 
			delayed := answer at: 2.
			positive := delayed at: 1.
			negative := delayed at: 2.
			aBoolean
				ifTrue:
					["we are waiting on not(anSLGCall)"

					anSLGCall unfilteredAnswers isEmpty
						ifTrue:
							["this call has no answers, so we can remove this"

							negative := negative reject: [:x | x = anSLGCall]	"negative remove: anSLGCall."
]
						ifFalse:
							[anSLGCall answers isEmpty
								ifFalse:
									["we have a real answer, so our answer is incorrect"

									answers remove: answer]]]
				ifFalse:
					["we are waiting on anSLGCall"

					anSLGCall unfilteredAnswers isEmpty
						ifTrue:
							["SLGCall has no solutions, remove answer"

							answers remove: answer]
						ifFalse:
							[anSLGCall answers isEmpty
								ifFalse:
									["we have a real answer, so remove delayed literal"

									positive remove: anSLGCall]]]]
]

{ #category : #accessing }
SLGCall >> unfilteredAnswers [
	
	^answers
]
