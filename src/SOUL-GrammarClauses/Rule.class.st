Class {
	#name : #Rule,
	#superclass : #ConcludableClause,
	#category : 'SOUL-GrammarClauses'
}

{ #category : #visitor }
Rule >> accept: aVisitor [
	
	^aVisitor ruleVisit: self
]

{ #category : #parsing }
Rule >> addChildrenInitial: aCollection [
	
	super
		condition: aCollection last
		conclusion: aCollection first
]

{ #category : #private }
Rule >> allAfter: anObject in: aCollection [
	
	| startIndex |
	startIndex := aCollection indexOf: anObject.
	^aCollection
		copyFrom: startIndex + 1
		to: aCollection size
]

{ #category : #private }
Rule >> allBefore: anObject in: aCollection [
	
	^aCollection copyUpTo: anObject
]

{ #category : #converting }
Rule >> asTabledRuleWithConditionString: aString [
	
	^TabledRule condition: condition conclusion: conclusion conditionString:
			aString
]

{ #category : #SLG }
Rule >> bridgeContinuationRulesFor: aCallTerm withTabledRule: aTabledRule sequenceNr: anInteger remainingConditions: aTermCollection withContinuationString: aString withCallGraph: aCallGraph [
	
	| tabledCall callTransformer splitIndex ownConditions contConditions rules vars beforeVarConditions slgcallString conditionVarString |
	callTransformer := self detectBridgeCallIn: aTermCollection
		withTabledRule: aTabledRule withCallGraph: aCallGraph.
	callTransformer isNil
		ifTrue:
			[^OrderedCollection
				with:
					(self bridgeEndRuleWith: anInteger callTerm: aCallTerm conditions:
							aTermCollection continuationString: aString)]
		ifFalse:
			[^self halt:
					'not yet implemented, why on earth do you call one rule twice :(']
]

{ #category : #SLG }
Rule >> bridgeEndRuleWith: anInteger callTerm: resultTerm conditions: aTermCollection continuationString: aString vars: vars [
	
	| conditionVarString |
	conditionVarString := '(?Id, vars asString,' , resultTerm asString ,
			', ?D, ?Cont)'.
	^self
		generateRule:
			self predicate , 'bridge' , anInteger asString , conditionVarString ,
					' if '
				,
					(aTermCollection isEmpty
						ifTrue: ['']
						ifFalse: [(TermSequence terms: aTermCollection) printString , ',']) ,
					aString
		onError: [:e :p | self halt]
]

{ #category : #SLG }
Rule >> bridgeImplementationRulesFor: aTermCollection withTabledRule: aTabledRule withCallGraph: aCallGraph withContinuationString: aString [
	"we differ from the paper here: the paper passes a continuation, which is already known at compile-time, so we just inline the continuation.
	The only problem that I see is when you have a tabled rule with 2 implementations (for example foo :- bar, baz and foo :- bar, meh), so we
	need to transform the bridge twice and dont pass the same continuation.
	why we do it like this is because it fits better in the whole approach/scheme/code we did for the 1st paper, and reimplementing it would cost me another
	month (and probably a trip straight to the psych)."

	
	| rules callTransformer bridgeCall conclusionString remainingConditions previousConditions ruleString previousConditionsString vars slgcallString |
	callTransformer := self detectBridgeCallIn: aTermCollection
		withTabledRule: aTabledRule withCallGraph: aCallGraph.
	conclusionString := self predicate , 'bridge' , '(?Id)'.
	callTransformer isNil
		ifTrue: [self halt: 'bridge predicate without a bridge Oo']
		ifFalse:
			[bridgeCall := callTransformer tabledCall.
			previousConditions := self allBefore: bridgeCall in: aTermCollection.
			remainingConditions := self allAfter: bridgeCall in: aTermCollection.
			vars := self
				environmentVariablesForCallTerm: bridgeCall
				inRuleWithConclusion: self conclusion
				termsBefore: previousConditions
				termsAfter: remainingConditions.
			rules := self bridgeContinuationRulesFor: bridgeCall withTabledRule:
					aTabledRule sequenceNr: 0 remainingConditions: remainingConditions
				withContinuationString: aString withCallGraph: aCallGraph.
			previousConditionsString := (TermSequence terms: previousConditions)
				printString.
			previousConditionsString = ''
				ifFalse: [previousConditionsString := previousConditionsString , ','].
			slgcallString := callTransformer transform: vars.
			ruleString := conclusionString , ' if ' , previousConditionsString ,
					slgcallString].
	rules
		addFirst:
			(self
				generateRule: ruleString
				onError: [:a :b | self error: 'Something went terribly wrong!']).
	^rules
]

{ #category : #SLG }
Rule >> detectBridgeCallIn: aTermCollection withTabledRule: aRule withCallGraph: aCallGraph [
	
	aTermCollection
		detect:
			[:aTerm | 
			aTerm isCompoundTerm
				ifTrue:
					[aTerm functor asString = 'not'
						ifFalse:
							[(aCallGraph isTermConnected: aTerm withClause: aRule) isEmpty not]
						ifTrue: [false]]
				ifFalse: [false]]
		ifNone: [nil]
]

{ #category : #private }
Rule >> environmentVariablesForCallTerm: aCallOfTabledPredicate inRuleWithConclusion: aConclusion termsBefore: beforeCollection termsAfter: afterCollection [
	"taken from the paper: all variables in the head must be passed to the cont of Li
	in addition all vars that occur BOTH in L1..Li-1 and Li..Ln must be passed to cont Li
	aCallOfTabledPredicate is Li, aConclusion is the conclusion of the rule we are transforming"

	"TODO: should be possible to capture the actual environment instead (c) Coen"

	
	| left right lfree rfree varsintersected |
	left := OrderedCollection new.
	left addAll: beforeCollection.
	left add: aConclusion.
	lfree := self variableNamesIn: (TermSequence terms: left).
	right := OrderedCollection new.
	right addAll: afterCollection.
	right add: aConclusion.
	right add: aCallOfTabledPredicate.
	rfree := self variableNamesIn: (TermSequence terms: right).
	varsintersected := (lfree select: [:v | rfree includes: v])
		asOrderedCollection.
	^ListTerm
		newFromCollection:
			(varsintersected collect: [:name | Variable name: name])
]

{ #category : #private }
Rule >> fixClean: fixVisitor [
	
	conclusion accept: fixVisitor.
	condition do: [:each | each accept: fixVisitor]
]

{ #category : #private }
Rule >> generateRule: aString onError: aBlock [
	
	| newRule |
	newRule := (SoulFactory current makeParser parse: aString onError: aBlock)
		clauses first.
	newRule recursiveDefinitionRepository: self definitionRepository.	"newRule condition definitionRepository: (self definitionRepository).
 	newRule conclusion definitionRepository: (self definitionRepository).
	newRule definitionRepository: (self definitionRepository)."

	^newRule
]

{ #category : #SLG }
Rule >> isBridgeNeeded: aTabledRule withCallGraph: aCallGraph [
	
	| bridgeCall allAfter terms |
	terms := self condition term terms.
	bridgeCall := self detectBridgeCallIn: terms withTabledRule: aTabledRule
		withCallGraph: aCallGraph.
	allAfter := self allAfter: bridgeCall in: terms.
	^allAfter isEmpty not
]

{ #category : #printing }
Rule >> prettyPrintOn: aStream scope: id [
	
	self prettyPrintCommentOn: aStream.
	conclusion prettyPrintOn: aStream scope: id.
	aStream withAttributes:(Array with:(TextEmphasis bold) with: (TextColor color:(Color red))) do:[
	aStream
		write: ' if ';
		cr].
	condition prettyPrintOn: aStream scope: id
]

{ #category : #printing }
Rule >> printAsPrologOn: aStream [
	
	| processedVariables |
	conclusion printAsPrologOn: aStream scope: #asClause in: nil startAt: nil.
	aStream
		write: ' :- ';
		crtab.	"UGLY: bweeeuuuk...."

	processedVariables := Set new.
	conclusion
		accept:
			(SoulFactory current makeNamedVariableVisitor
				doBlock:
					[:aVariable | 
					(aVariable isKindOf: PosVariable)
						& (processedVariables includes: aVariable) not
						ifTrue:
							[processedVariables add: aVariable.
							aStream write: 'nonvar('.
							aVariable printAsPrologOn: aStream scope: #asTerm in: nil startAt:
									nil.
							aStream
								write: '),';
								crtab].
					(aVariable isKindOf: NegVariable)
						& (processedVariables includes: aVariable) not
						ifTrue:
							[processedVariables add: aVariable.
							aStream write: 'var('.
							aVariable printAsPrologOn: aStream scope: #asTerm in: nil startAt:
									nil.
							aStream
								write: '),';
								crtab]]).
	condition printAsPrologOn: aStream scope: #asClause in: nil startAt: nil.
	aStream
		write: '.';
		cr
]

{ #category : #printing }
Rule >> printForCompileOn: aStream [
	
	aStream write: '(' , self class name , ' condition: ('.
	condition printForCompileOn: aStream.
	aStream write: ') conclusion: ('.
	conclusion printForCompileOn: aStream.
	aStream write: '))'.
	self hasComment
		ifTrue:
			[aStream write: ' comment: ' , self comment storeString , '; yourself']
]

{ #category : #printing }
Rule >> printOn: aStream [
	
	self printCommentOn: aStream.
	conclusion printOn: aStream.
	aStream
		write: ' if ';
		crtab.
	condition printOn: aStream
]

{ #category : #SLG }
Rule >> transformBridge: aTabledRule withCallGraph: aCallGraph [
	
	^self
		bridgeContinuationRules: self condition term
		withTabledRule: aTabledRule
		withCallGraph: aCallGraph
]

{ #category : #private }
Rule >> variableNamesIn: aTerm [
	
	| variables variableVisitor |
	variables := OrderedCollection new.
	variableVisitor := SoulFactory current makeNamedVariableVisitor
		doBlock:
			[:var | 
			var isHiddenVariable
				ifFalse:
					[(variables includes: (var name asSymbol))
						ifFalse:[variables add: (var name asSymbol)]
						]].
	aTerm accept: variableVisitor.
	^variables
]
