SLG
bridgeImplementationRulesFor: aTermCollection withTabledRule: aTabledRule withCallGraph: aCallGraph withContinuationString: aString
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