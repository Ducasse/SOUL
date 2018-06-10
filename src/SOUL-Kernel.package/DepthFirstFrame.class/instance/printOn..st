printing
printOn: aStream
	
	aStream
		print: self class;
		nextPutAll: ' ['.
	conditionsList printOn: aStream.
	aStream nextPut: $]