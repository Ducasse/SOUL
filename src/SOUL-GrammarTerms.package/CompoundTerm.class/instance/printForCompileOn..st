printing
printForCompileOn: aStream
	"see comment in AbstractTerm"

	
	aStream write: self class name , ' functor:('.
	functor printForCompileOn: aStream.
	aStream write: ') termSequence:('.
	termsequence printForCompileOn: aStream.
	aStream write: ')'