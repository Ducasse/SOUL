printing
printOn: aStream
	
	| stringRepresentation |
	stringRepresentation := callTerm asString.
	aStream write: stringRepresentation