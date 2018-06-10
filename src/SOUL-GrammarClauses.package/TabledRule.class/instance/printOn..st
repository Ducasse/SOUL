printing
printOn: aStream
	
	self printCommentOn: aStream.
	aStream write: 'tabled '.
	conclusion printOn: aStream.
	aStream
		write: ' if ';
		crtab.
	aStream nextPutAll: conditionString