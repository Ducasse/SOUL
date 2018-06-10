private
slgContinuationRulesFor: aCallTerm withTabledRules: aCollection sequenceNr: anInteger remainingConditions: aTermCollection endVars: endVars withCallGraph: aCallGraph
	
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