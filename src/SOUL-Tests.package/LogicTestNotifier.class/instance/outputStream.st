Private-accessing
outputStream
	
	outputStream isNil ifTrue: [outputStream := Transcript].
	^outputStream