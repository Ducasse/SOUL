reification
soulDownIn: anEnv startAt: anIndex
	"myself or my downed value"

	
	| value |
	value := anEnv lookup: self startAt: anIndex.
	value isNil
		ifTrue: [^self]
		ifFalse:
			[^value term
				soulDownIn: anEnv
				startAt: value envIndex]