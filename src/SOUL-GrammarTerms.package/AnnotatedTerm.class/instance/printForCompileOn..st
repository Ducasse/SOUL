printing
printForCompileOn: aStream
	
	aStream write: self class name , ' term: ('.
	term printForCompileOn: aStream.
	aStream write: ') annotation: ('.
	annotation printForCompileOn: aStream.
	aStream write: ')'