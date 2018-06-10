reification
soulDownIn: anEnv startAt: anIndex
	
	| value |
	value := anEnv lookup: self startAt: anIndex.
	value isNil
		ifTrue: [^self]
		ifFalse:
			[^value term
				transitiveLookupIn: anEnv
				startAt: value envIndex]