reification
transitiveLookupIn: anEnv startAt: anIndex
	"myself or my downed value"

	
	| value |
	value := anEnv lookup: self startAt: anIndex.
	(value isNil or: [value term == self])
		ifTrue: [^self]
		ifFalse:
			[^value term
				transitiveLookupIn: anEnv
				startAt: value envIndex]