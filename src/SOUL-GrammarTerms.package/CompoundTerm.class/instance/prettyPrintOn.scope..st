printing
prettyPrintOn: aStream scope: id
	
	| newId |
	id = #asClause
		ifTrue: [newId := #asClause]
		ifFalse: [newId := #asTerm].
	functor prettyPrintAsFunctorOn: aStream scope: newId.
	aStream write: '('.
	termsequence
		do: [:aterm | aterm prettyPrintOn: aStream scope: #asTerm]
		separatedBy: [aStream write: ','].
	aStream write: ')'