SLG
slgImplementationRulesFor: aSoulRule
	
	| tabledCall rules conclusionString ruleString previousConditionsString remainingConditions previousConditions vars |
	conclusionString := 'slg'
		, (aSoulRule conclusion printString allButLast: 1) , ',?Id)'.
	tabledCall := self
		detectTabledCallIn: aSoulRule condition terms
		using: aSoulRule conclusion.
	tabledCall isNil
		ifTrue:
			[ruleString := conclusionString , ' if ' , aSoulRule condition printString
				, ',answer(?Id,' , aSoulRule conclusion printString , ',0)'.
			rules := OrderedCollection new]
		ifFalse:
			["If a call to a tabled predicate (or a recursive call is present)"

			remainingConditions := self
				allAfter: tabledCall
				in: aSoulRule condition terms.
			previousConditions := self
				allBefore: tabledCall
				in: aSoulRule condition terms.
			vars := self
				environmentVariablesForCallTerm: tabledCall
				inRuleWithConclusion: aSoulRule conclusion
				termsBefore: previousConditions
				termsAfter: remainingConditions.
			rules := self slgContinuationRulesFor: aSoulRule sequenceNr: 0 callTerm:
					tabledCall remainingConditions: remainingConditions endVars: vars.
			previousConditionsString := (TermSequence terms: previousConditions)
				printString.
			previousConditionsString = ''
				ifFalse: [previousConditionsString := previousConditionsString , ','].
			ruleString := conclusionString , ' if ' , previousConditionsString ,
					'slgcall(?Id, ' , vars asString , ',' , tabledCall printString , ',0,'
				, aSoulRule predicate asString , 'cont0)'].
	rules
		addFirst:
			(SoulFactory current makeParser
				parse: ruleString
				onError: [:a :b | self error: 'Something went terribly wrong!'])
				clauses first.
	^rules