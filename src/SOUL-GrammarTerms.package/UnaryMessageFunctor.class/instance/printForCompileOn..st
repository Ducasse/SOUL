printing
printForCompileOn: aStream
	
	aStream write: self class name , ' message: ('.
	message printForCompileOn: aStream.
	aStream write: ')'