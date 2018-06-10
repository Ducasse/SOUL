printing
printForCompileOn: aStream
	"see comment in AbstractTerm"

	
	aStream write: self class name , ' terms: (OrderedCollection new '.
	self terms
		do:
			[:currentClause | 
			aStream write: 'add:('.
			currentClause printForCompileOn: aStream.
			aStream write: ')']
		separatedBy: [aStream write: ';'].
	aStream write: ';yourself) containsCut: ' , self containsCut asString