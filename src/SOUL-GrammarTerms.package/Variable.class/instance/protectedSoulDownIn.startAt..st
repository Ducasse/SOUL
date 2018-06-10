reification
protectedSoulDownIn: anEnv startAt: anIndex
	"my downed value or an error"

	
	| value |
	value := anEnv lookup: self startAt: anIndex.
	value isNil
		ifTrue: [UnboundVariableException signal]
		ifFalse:
			[^value term
				soulDownIn: anEnv
				startAt: value envIndex]