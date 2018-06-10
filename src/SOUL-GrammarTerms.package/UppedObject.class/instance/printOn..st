printing
printOn: aStream
	"see comment in QSOULAbstractTerm"

	
	aStream write: '['.
	smalltalkValue printOn: aStream.
	aStream write: ']'