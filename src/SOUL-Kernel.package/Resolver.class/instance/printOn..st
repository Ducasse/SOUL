printing
printOn: aStream
	
	aStream
		print: self class;
		nextPutAll: ' <'.
	clauseIndex printOn: aStream.
	aStream nextPut: $/.
	delayedClauses size printOn: aStream.
	aStream nextPut: $>