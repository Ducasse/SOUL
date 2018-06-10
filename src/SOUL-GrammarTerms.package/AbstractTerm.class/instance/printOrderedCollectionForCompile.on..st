private
printOrderedCollectionForCompile: collection on: aStream
	
	aStream write: 'OrderedCollection new'.
	collection
		do:
			[:element | 
			aStream write: 'add:('.
			element printForCompileOn: aStream.
			aStream write: ')']
		separatedBy: [aStream write: ';'].
	aStream write: ';yourself'