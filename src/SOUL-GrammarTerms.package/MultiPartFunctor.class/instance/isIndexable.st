testing
isIndexable
	
	self keywords
		detect: [:keyword | keyword isKindOf: Variable]
		ifNone: [^true].
	^false