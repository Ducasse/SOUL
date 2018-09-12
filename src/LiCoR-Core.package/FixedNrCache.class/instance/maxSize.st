private-accessing
maxSize
	
	^maxSize isNil
		ifTrue: [maxSize := self defaultMaxSize]
		ifFalse: [maxSize]