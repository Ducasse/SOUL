printing
printOn: aStream
	
	self printCommentOn: aStream.
	conclusion printOn: aStream.
	aStream
		write: ' if ';
		crtab.
	condition printOn: aStream