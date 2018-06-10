printing
prettyPrintKeywordStyleOn: aStream scope: id
	
	| newId |
	id = #asClause
		ifTrue: [newId := #asClause]
		ifFalse: [newId := #asTerm].
	self functor keywords
		with: termsequence terms
		do:
			[:keyword :aterm | 
			keyword prettyPrintAsKeywordOn: aStream scope: newId.
			aStream write: ': '.
			aterm prettyPrintAsKeywordArgOn: aStream scope: newId]
		separatedBy: [aStream write: ' ']