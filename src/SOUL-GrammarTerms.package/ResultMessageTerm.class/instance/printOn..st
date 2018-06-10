printing
printOn: aStream
	
	messageTerm printOn: aStream.
	aStream nextPutAll: ' = '.
	resultTerm printOn: aStream