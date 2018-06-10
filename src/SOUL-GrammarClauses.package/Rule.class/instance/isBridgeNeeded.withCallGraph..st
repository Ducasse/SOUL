SLG
isBridgeNeeded: aTabledRule withCallGraph: aCallGraph
	
	| bridgeCall allAfter terms |
	terms := self condition term terms.
	bridgeCall := self detectBridgeCallIn: terms withTabledRule: aTabledRule
		withCallGraph: aCallGraph.
	allAfter := self allAfter: bridgeCall in: terms.
	^allAfter isEmpty not