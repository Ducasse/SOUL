SLG
bridgeContinuationRulesFor: aCallTerm withTabledRule: aTabledRule sequenceNr: anInteger remainingConditions: aTermCollection withContinuationString: aString withCallGraph: aCallGraph
	
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