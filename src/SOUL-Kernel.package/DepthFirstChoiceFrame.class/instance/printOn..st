printing
printOn: aStream
	
	aStream
		print: self class;
		nextPutAll: ' ('.
	resolver printOn: aStream.
	aStream nextPutAll: ')['.
	conditionsList printOn: aStream.
	aStream nextPut: $]