printing
printForCompileOn: aStream
	"see comment in AbstractTerm"

	
	aStream write: self class name , ' variable: ('.
	variable printForCompileOn: aStream.
	aStream write: ') term: ('.
	normalterm printForCompileOn: aStream.
	aStream write: ')'