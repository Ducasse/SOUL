converting
slgTransformWith: aTabledRuleCollection withCallGraph: aCallGraph
	
	| newRules |
	self generatedRules: OrderedCollection new.
	newRules := self
		slgImplementationRulesFor: self condition terms
		withTabledRules: aTabledRuleCollection
		withCallGraph: aCallGraph.
	self generatedRules addAll: newRules.
	^newRules