printing
printOn: aStream
	
	aStream
		write: 'SOUL found';
		cr;
		write:
				self size asString , ' solutions in ' , timeTaken asString , ' ms for:';
		cr.
	query printOn: aStream.
	aStream
		cr;
		cr;
		cr.
	self printBasicInformationOn: aStream