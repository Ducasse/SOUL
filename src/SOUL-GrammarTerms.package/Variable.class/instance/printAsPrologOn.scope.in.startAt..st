printing
printAsPrologOn: aStream scope: anObject in: env startAt: idx
	
	| value |
	"TODO: Should use a dummy environment instead of nil values"

	(env isNil or: [(value := env lookup: self startAt: idx) isNil])
		ifTrue: [aStream write: self capitalizedName]
		ifFalse:
			[value term
				printAsPrologOn: aStream
				scope: anObject
				in: env
				startAt: value envIndex]