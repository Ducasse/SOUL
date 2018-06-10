printing
printOn: aStream
	
	keywords
		do:
			[:keyword | 
			keyword printOn: aStream.
			aStream write: ':']