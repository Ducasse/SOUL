printing
printOn: aStream
	"see comment in AbstractTerm"

	
	collection
		do: [:term | term printOn: aStream]
		separatedBy: [aStream write: ',']