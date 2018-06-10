SLG
transformBridge: aTabledRule withCallGraph: aCallGraph
	
	^self
		bridgeContinuationRules: self condition term
		withTabledRule: aTabledRule
		withCallGraph: aCallGraph