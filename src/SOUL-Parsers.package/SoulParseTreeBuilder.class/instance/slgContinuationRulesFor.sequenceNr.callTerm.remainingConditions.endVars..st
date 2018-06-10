SLG
slgContinuationRulesFor: originalSoulRule sequenceNr: anInteger callTerm: resultTerm remainingConditions: aTermCollection endVars: endVars
	
	| tabledCall splitIndex ownConditions contConditions rules vars |
	tabledCall := self
		detectTabledCallIn: aTermCollection
		using: originalSoulRule conclusion.
	tabledCall isNil
		ifTrue:
			[^OrderedCollection
				with:
					(self slgAnswerRuleFor: originalSoulRule sequenceNr: anInteger callTerm:
							resultTerm conditions: aTermCollection environmentVariables: endVars)]
		ifFalse:
			[splitIndex := aTermCollection indexOf: tabledCall.
			ownConditions := splitIndex = 1
				ifTrue: [ownConditions := OrderedCollection new]
				ifFalse: [aTermCollection copyUpTo: splitIndex - 1].
			contConditions := aTermCollection
				copyFrom: splitIndex + 1
				to: aTermCollection size.
			vars := self
				environmentVariablesForCallTerm: tabledCall
				inRuleWithConclusion: originalSoulRule conclusion
				termsBefore: ownConditions
				termsAfter: contConditions.
			rules := self
				slgContinuationRulesFor: originalSoulRule
				sequenceNr: anInteger + 1
				callTerm: tabledCall
				remainingConditions: contConditions
				endVars: vars copy.	"rules
				addFirst: (Soul.Factory current makeParser
						parse: originalSoulRule predicate , 'cont' , anInteger asString
								, '(?Id,?Vars,' , resultTerm asString
								, ',D) if ' , (TermSequence terms: ownConditions) printString
						onError: [:e | self halt]) clauses
						first."

			rules
				addFirst:
					(SoulFactory current makeParser
						parse:
							originalSoulRule predicate , 'cont' , anInteger asString , '(?Id,'
								, endVars asString , ',' , resultTerm asString , ',D) if '
								, (TermSequence terms: ownConditions) printString , 'slgcall(?Id, '
								, vars asString , ',' , tabledCall printString , ',0,'
								, (originalSoulRule predicate , 'cont' , (anInteger + 1) asString)
								, ')'
						onError: [:e | self halt]) clauses first.
			^rules]