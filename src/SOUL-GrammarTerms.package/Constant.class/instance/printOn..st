printing
printOn: aStream
	"see comment in AbstractTerm"

	
	| stringRepresentation |
	stringRepresentation := smalltalkValue asString.
	(stringRepresentation includes: $:) ifTrue: [aStream write: '#'].
	aStream write: smalltalkValue asString