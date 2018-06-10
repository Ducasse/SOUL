printing
printOn: aStream
	"see comment in AbstractTerm"

	"aStream write: '&' , name , ':' , address asString"

	
	aStream write: '+?' , name