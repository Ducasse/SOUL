printing
printForCompileOn: aStream
	"see comment in AbstractTerm"

	
	aStream write: self class name , ' name: '''.
	aStream write: name.
	aStream write: ''''