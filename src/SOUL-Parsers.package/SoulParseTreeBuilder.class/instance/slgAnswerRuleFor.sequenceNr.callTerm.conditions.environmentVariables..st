SLG
slgAnswerRuleFor: originalSoulTerm sequenceNr: anInteger callTerm: resultTerm conditions: aTermCollection environmentVariables: vars
	
	| answer |
	answer := originalSoulTerm conclusion.
	^(SoulFactory current makeParser
		parse:
			originalSoulTerm predicate , 'cont' , anInteger asString , '(?Id,'
				, vars asString , ',' , resultTerm asString , ',D) if '
				,
					(aTermCollection isEmpty
						ifTrue: ['']
						ifFalse: [(TermSequence terms: aTermCollection) printString , ',']) ,
					'answer(?Id,' , answer asString , ',D)'
		onError: [:e :p | self halt]) clauses first