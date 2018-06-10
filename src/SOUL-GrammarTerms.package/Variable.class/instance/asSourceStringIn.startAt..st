converting
asSourceStringIn: anEnv startAt: anIndex
	"see comment in AbstractTerm"

	"if I am bound, return the sourcestring of my bound value"

	
	| value |
	value := anEnv lookup: self startAt: anIndex.
	value isNil
		ifTrue: [^self asString]
		ifFalse:
			[^value term
				asSourceStringIn: anEnv
				startAt: value envIndex]