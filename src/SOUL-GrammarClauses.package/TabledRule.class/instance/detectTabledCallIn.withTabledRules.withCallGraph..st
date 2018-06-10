private
detectTabledCallIn: aTermCollection withTabledRules: aCollection withCallGraph: aCallGraph
	"Check if the conditions contain a call to a tabled predicate or bridge predicate
	aCollection is a collection of TabledRules.
	Returns a transformer, which can be called to get the transformation.
	Returns nil if no such rule is found"

	
	| names |
	names := aCollection
		collect:
			[:rule | rule conclusion functor printString , rule conclusion multiplicity asString].
	aTermCollection
		do:
			[:aCondition | 
			aCondition isCompoundTerm
				and:
					["either we have a direct call to a tabled call" 
					names
						do:
							[:name | 
							name = (aCondition functor printString , aCondition multiplicity asString)
								ifTrue:
									[^TabledRuleSLGCallTransformer with: aCondition fromRule: self].
							(self isTabledNotCall: aCondition withTabledName: name)
								ifTrue:
									[^TabledRuleSLGNotTransformer with: aCondition fromRule: self]]	"(self isBridgeCall: aCondition withCallGraph: aCallGraph) ifTrue:
					[ ^TabledRuleBridgeTransformer with: aCondition fromRule: self ]."
]].
	^nil