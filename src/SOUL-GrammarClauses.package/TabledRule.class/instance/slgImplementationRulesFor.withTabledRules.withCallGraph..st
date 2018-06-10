private
slgImplementationRulesFor: aTermCollection withTabledRules: aCollection withCallGraph: aCallGraph
	
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