SLG
detectBridgeCallIn: aTermCollection withTabledRule: aRule withCallGraph: aCallGraph
	
	aTermCollection
		detect:
			[:aTerm | 
			aTerm isCompoundTerm
				ifTrue:
					[aTerm functor asString = 'not'
						ifFalse:
							[(aCallGraph isTermConnected: aTerm withClause: aRule) isEmpty not]
						ifTrue: [false]]
				ifFalse: [false]]
		ifNone: [nil]