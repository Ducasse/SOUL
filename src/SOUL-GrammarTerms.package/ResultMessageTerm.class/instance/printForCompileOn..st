printing
printForCompileOn: aStream
	
	aStream nextPutAll: self class name , ' message: ('.
	messageTerm printForCompileOn: aStream.
	aStream nextPutAll: ') result: ('.
	resultTerm printForCompileOn: aStream.
	aStream nextPutAll: ')'