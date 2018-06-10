printing
printForCompileOn: aStream
	
	aStream write: self class name , ' condition: ('.
	condition printForCompileOn: aStream.
	aStream write: ')'