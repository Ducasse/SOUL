printing
printForCompileOn: aStream
	"see comment in AbstractTerm"

	
	aStream write: self class name , ' source: '.
	source printOn: aStream