printing
printOn: aStream
	"see comment in AbstractTerm"

	
	variable printOn: aStream.
	aStream write: '->'.
	normalterm printOn: aStream