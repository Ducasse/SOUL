Class {
	#name : #TabledRule,
	#superclass : #Rule,
	#instVars : [
		'conditionString',
		'generatedRules'
	],
	#category : 'SOUL-GrammarClauses'
}

{ #category : #'instance creation' }
TabledRule class >> condition: condition conclusion: conclusion conditionString: aString [
	
	^(super condition: condition conclusion: conclusion) conditionString:
			aString
]

{ #category : #converting }
TabledRule class >> transformTabledRules: aCollection withCallGraph: aCallGraph [
	
	| uniqueRules newRules key values |
	newRules := OrderedCollection new.
	uniqueRules := Dictionary new.
	aCollection
		do:
			[:aTabledRule | 
			key := aTabledRule conclusion functor asString.
			values := uniqueRules
				at: key
				ifAbsent: [OrderedCollection new].
			values
				detect: [:x | x conclusion isSLGEquivalentTo: aTabledRule conclusion]
				ifNone: [values add: aTabledRule].
			uniqueRules at: key put: values].
	uniqueRules
		do:
			[:rules | rules do: [:aTabledRule | newRules add: aTabledRule slgTransformMain]].
	aCollection
		do:
			[:aTabledRule | 
			newRules
				addAll:
					(aTabledRule slgTransformWith: aCollection withCallGraph: aCallGraph)].
	^newRules
]

{ #category : #accessing }
TabledRule >> addGeneratedRule: aRule [
	
	generatedRules add: aRule
]

{ #category : #repository }
TabledRule >> addToRepository: aRepository [
	super addToRepository: aRepository.
	aRepository addTabledRule: self
]

{ #category : #accessing }
TabledRule >> conditionString: aString [
	
	conditionString := aString
]

{ #category : #private }
TabledRule >> detectTabledCallIn: aTermCollection withTabledRules: aCollection withCallGraph: aCallGraph [
	"Check if the conditions contain a call to a tabled predicate or bridge predicate
	aCollection is a collection of TabledRules.
	Returns a transformer, which can be called to get the transformation.
	Returns nil if no such rule is found"

	
	| names |
	names := aCollection
		collect:
			[:rule | rule conclusion functor printString , rule conclusion multiplicity asString].
	aTermCollection
		do:
			[:aCondition | 
			aCondition isCompoundTerm
				and:
					["either we have a direct call to a tabled call" 
					names
						do:
							[:name | 
							name = (aCondition functor printString , aCondition multiplicity asString)
								ifTrue:
									[^TabledRuleSLGCallTransformer with: aCondition fromRule: self].
							(self isTabledNotCall: aCondition withTabledName: name)
								ifTrue:
									[^TabledRuleSLGNotTransformer with: aCondition fromRule: self]]	"(self isBridgeCall: aCondition withCallGraph: aCallGraph) ifTrue:
					[ ^TabledRuleBridgeTransformer with: aCondition fromRule: self ]."
]].
	^nil
]

{ #category : #private }
TabledRule >> generateContinuationHead: anInteger [
	
	^'cont' , anInteger asString , self predicate reject: [:x | x = $:]
]

{ #category : #private }
TabledRule >> generateRule: aString onError: aBlock [
	
	| newRule |
	newRule := (SoulFactory current makeParser parse: aString onError: aBlock)
		clauses first.
	newRule recursiveDefinitionRepository: self definitionRepository.	"newRule condition definitionRepository: (self definitionRepository).
 	newRule conclusion definitionRepository: (self definitionRepository).
	newRule definitionRepository: (self definitionRepository)."

	self generatedRules add: newRule.
	^newRule
]

{ #category : #private }
TabledRule >> generateSLGConclusion [
	
	| functor |
	functor := self conclusion functor.
	functor isMessageFunctor
		ifTrue:
			[| result terms |
			terms := self conclusion termSequence terms.
			result := '?Id id: ' , (terms at: 1) asString , ' slg'.
			functor keywords
				doWithIndex:
					[:keyword :i | result := result , keyword asString , ': ' , (terms at: i + 1) asString].
			^result]
		ifFalse:
			[^'slg' , functor asString , '(?Id,'
				, self conclusion termSequence asString , ')']
]

{ #category : #accessing }
TabledRule >> generatedRules [
	
	generatedRules ifNil: [generatedRules := OrderedCollection new].
	^generatedRules
]

{ #category : #accessing }
TabledRule >> generatedRules: aCollection [
	
	generatedRules := aCollection
]

{ #category : #private }
TabledRule >> isBridgeCall: aTerm withCallGraph: aCallGraph [
	"not calls are no bridges (I think), as not's can not generate bindings for variables
	as they are supposed to be ground"

	
	| connectedBy bridges |
	aTerm functor asString = 'not'
		ifFalse:
			[connectedBy := aCallGraph isTermConnected: aTerm withClause: self.
			bridges := connectedBy
				collect: [:term | term isBridgeNeeded: self withCallGraph: aCallGraph].
			^bridges isEmpty not]
		ifTrue: [^false]
]

{ #category : #private }
TabledRule >> isTabledNotCall: aCondition withTabledName: aString [
	"checks if aCondition is of the form not(aString) where aString is path(a,b)/2"

	"valiant knight, please prepare for horror and a princess in another castle"

	
	| theElement |
	aCondition functor printString = 'not' ifFalse: [^false].	"we restrict this to nots with only 1 term"
	"TODO: change this? watch out as we need to do variable passing and other nasty stuff"

	aCondition termSequence size = 1 ifFalse: [^false].
	theElement := aCondition termSequence terms first.
	^aString
		= (theElement functor asString , theElement multiplicity asString)
]

{ #category : #testing }
TabledRule >> isTabledRule [
	
	^true
]

{ #category : #printing }
TabledRule >> prettyPrintOn: aStream scope: id [
	
	self prettyPrintCommentOn: aStream.
	aStream withAttributes:(Array with: TextEmphasis italic with:(TextColor blue)) do:[
		aStream write: 'tabled '.
	].
	^super prettyPrintOn: aStream scope: id
]

{ #category : #printing }
TabledRule >> printForCompileOn: aStream [
	
	aStream write: '(' , self class name , ' condition: ('.
	condition printForCompileOn: aStream.
	aStream write: ') conclusion: ('.
	conclusion printForCompileOn: aStream.
	aStream write: ') conditionString: ('.
	conditionString printOn: aStream.
	aStream nextPutAll: '))'.
	self hasComment
		ifTrue:
			[aStream write: ' comment: ' , self comment storeString , '; yourself']
]

{ #category : #printing }
TabledRule >> printOn: aStream [
	
	self printCommentOn: aStream.
	aStream write: 'tabled '.
	conclusion printOn: aStream.
	aStream
		write: ' if ';
		crtab.
	aStream nextPutAll: conditionString
]

{ #category : #private }
TabledRule >> slgAnswerRuleWith: anInteger callTerm: resultTerm conditions: aTermCollection environmentVariables: vars [
	
	| answer conditionVarString |
	conditionVarString := resultTerm functor asString = 'not'
		ifTrue: ['(?Id,' , vars asString , ',?D)']
		ifFalse: ['(?Id,' , vars asString , ',' , resultTerm asString , ',?D)'].
	answer := self conclusion.
	^self
		generateRule:
			(self generateContinuationHead: anInteger) , conditionVarString , ' if '
				,
					(aTermCollection isEmpty
						ifTrue: ['']
						ifFalse: [(TermSequence terms: aTermCollection) printString , ',']) ,
					'answer(?Id,' , answer asString , ',?D)'
		onError: [:e :p | self halt]
]

{ #category : #private }
TabledRule >> slgContinuationRulesFor: aCallTerm withTabledRules: aCollection sequenceNr: anInteger remainingConditions: aTermCollection endVars: endVars withCallGraph: aCallGraph [
	
	| tabledCall callTransformer splitIndex ownConditions contConditions rules vars beforeVarConditions slgcallString conditionVarString |
	callTransformer := self detectTabledCallIn: aTermCollection
		withTabledRules: aCollection withCallGraph: aCallGraph.
	callTransformer isNil
		ifTrue:
			[^OrderedCollection
				with:
					(self slgAnswerRuleWith: anInteger callTerm: aCallTerm conditions:
							aTermCollection environmentVariables: endVars)]
		ifFalse:
			[tabledCall := callTransformer tabledCall.
			splitIndex := aTermCollection indexOf: tabledCall.
			ownConditions := splitIndex = 1
				ifTrue: [ownConditions := OrderedCollection new]
				ifFalse: [aTermCollection copyUpTo: splitIndex - 1].	"we need all the vars from L1 - Li-1, meaning we cant use remainingConditions as that only contains Lj - Ln, where Lj-1 is last tabled call"

			beforeVarConditions := self
				allBefore: aCallTerm
				in: condition terms.
			beforeVarConditions add: aCallTerm.
			contConditions := aTermCollection
				copyFrom: splitIndex + 1
				to: aTermCollection size.
			vars := self
				environmentVariablesForCallTerm: tabledCall
				inRuleWithConclusion: self conclusion
				termsBefore: beforeVarConditions
				termsAfter: contConditions.
			rules := self
				slgContinuationRulesFor: tabledCall
				withTabledRules: aCollection
				sequenceNr: anInteger + 1
				remainingConditions: contConditions
				endVars: vars copy
				withCallGraph: aCallGraph.
			slgcallString := callTransformer
				transform: vars
				withInteger: anInteger + 1.
			conditionVarString := '(?Id,' , endVars asString , ','
				, aCallTerm asString , ',?D)'.
			rules
				addFirst:
					(self
						generateRule:
							(self generateContinuationHead: anInteger) , conditionVarString , 'if '
								, (TermSequence terms: ownConditions) printString
								,
									(ownConditions isEmpty
										ifTrue: ['']
										ifFalse: [',']) , slgcallString
						onError: [:e | self halt]).
			^rules]
]

{ #category : #private }
TabledRule >> slgImplementationRulesFor: aTermCollection withTabledRules: aCollection withCallGraph: aCallGraph [
	
	| rules callTransformer tabledCall conclusionString remainingConditions previousConditions ruleString previousConditionsString vars slgcallString |
	conclusionString := self generateSLGConclusion.
	callTransformer := self detectTabledCallIn: aTermCollection
		withTabledRules: aCollection withCallGraph: aCallGraph.
	callTransformer isNil
		ifTrue:
			[ruleString := conclusionString , ' if ' , self condition printString ,
					', answer(?Id, ' , self conclusion printString ,
					',[ Array with: (OrderedCollection new) with: (OrderedCollection new) ])'.
			rules := OrderedCollection new]
		ifFalse:
			[tabledCall := callTransformer tabledCall.
			previousConditions := self allBefore: tabledCall in: aTermCollection.
			remainingConditions := self allAfter: tabledCall in: aTermCollection.
			vars := self
				environmentVariablesForCallTerm: tabledCall
				inRuleWithConclusion: self conclusion
				termsBefore: previousConditions
				termsAfter: remainingConditions.
			rules := self slgContinuationRulesFor: tabledCall withTabledRules:
					aCollection sequenceNr: 0 remainingConditions: remainingConditions
				endVars: vars withCallGraph: aCallGraph.
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

{ #category : #private }
TabledRule >> slgTransformMain [
	
	| literal newRule |
	literal := self conclusion printString.
	newRule := self
		generateRule: literal , ' if  slg(' , literal , ')'
		onError: [:a :b | self error: 'Something went terribly wrong!'].
	^newRule
]

{ #category : #converting }
TabledRule >> slgTransformWith: aTabledRuleCollection withCallGraph: aCallGraph [
	
	| newRules |
	self generatedRules: OrderedCollection new.
	newRules := self
		slgImplementationRulesFor: self condition terms
		withTabledRules: aTabledRuleCollection
		withCallGraph: aCallGraph.
	self generatedRules addAll: newRules.
	^newRules
]
