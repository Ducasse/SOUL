printing
printForCompileOn: aStream
	"see comment in AbstractTerm"

	
	aStream write: '('.
	super printForCompileOn: aStream.
	aStream write: ') decorators: (OrderedCollection new '.
	decorators
		do:
			[:each | 
			aStream write: 'add:('.
			each printForCompileOn: aStream.
			aStream write: ')']
		separatedBy: [aStream write: ';'].
	aStream write: ';yourself)'