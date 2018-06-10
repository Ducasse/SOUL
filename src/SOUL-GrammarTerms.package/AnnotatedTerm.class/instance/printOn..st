printing
printOn: aStream
	"see comment in AbstractTerm"

	
	term printOn: aStream.
	aStream write: ' : '.
	annotation printOn: aStream