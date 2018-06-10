accessing-local
predicateKeysIn: protocol
	
	| mapping |
	mapping := self selectorToPredicateKeyMapping.
	^(self organization listAtCategoryNamed: protocol)
		collect: [:selector | mapping at: selector]