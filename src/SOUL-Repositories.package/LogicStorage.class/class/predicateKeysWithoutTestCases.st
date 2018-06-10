test classes
predicateKeysWithoutTestCases
	
	| missingTestKeys |
	missingTestKeys := OrderedCollection new.
	self predicateKeys
		do:
			[:key | 
			self
				testMethodForPredicateKey: key
				ifAbsent: [missingTestKeys add: key]].
	^missingTestKeys