printing
printOn: aStream
	"see comment in AbstractTerm"

	
	aStream write: '['.
	aStream write: source.
	aStream write: ']'