printing
printForCompileOn: aStream
	
	aStream write: '^(' , self class name , ' terms: (OrderedCollection new '.
	collection
		do:
			[:currentClause | 
			aStream write: 'add:('.
			currentClause printForCompileOn: aStream.
			aStream write: ')']
		separatedBy: [aStream write: ';'].
	aStream write: ';yourself))'