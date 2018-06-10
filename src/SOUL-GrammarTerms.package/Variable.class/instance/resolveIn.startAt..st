resolving
resolveIn: anEnv startAt: anIndex
	"resolve my value"

	
	| val |
	val := anEnv lookup: self startAt: anIndex.
	^val isNil
		ifTrue: [self error: 'Trying to resolve an unbound variable']
		ifFalse:
			[val term
				resolveIn: anEnv
				startAt: val envIndex]