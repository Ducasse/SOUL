printing
printOn: aStream
	
	var printOn: aStream.
	aStream write: '-->'.
	value class == Environment
		ifTrue: [aStream write: '**env**']
		ifFalse: [value printOn: aStream]