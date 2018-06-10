printing
printUnaryMessageStyleOn: aStream
	
	termsequence terms first printOn: aStream.
	aStream write: ' '.
	functor message printOn: aStream