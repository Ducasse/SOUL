printing
printForCompileOn: aStream
	"see comment in AbstractTerm"

	
	aStream write: self class name , ' keywords: (OrderedCollection new '.
	self keywords
		do:
			[:keyword | 
			aStream write: 'add:('.
			keyword printForCompileOn: aStream.
			aStream write: ')']
		separatedBy: [aStream write: ';'].
	aStream write: ';yourself)'