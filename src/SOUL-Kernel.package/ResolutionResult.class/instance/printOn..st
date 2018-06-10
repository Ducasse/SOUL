printing
printOn: aStream
	
	aStream
		write: 'resolutionresult with conditions: ';
		cr.
	conditions printOn: aStream.
	aStream
		cr;
		write: ' and rollbackInfo: ';
		cr.
	rollbackInfo printOn: aStream.
	aStream cr