printing
printAsPrologOn: aStream scope: id in: env startAt: idx
	
	| newId |
	id = #asClause
		ifTrue: [newId := #asClause]
		ifFalse: [newId := #asTerm].
	functor printAsPrologFunctorOn: aStream scope: newId in: env startAt: idx.
	aStream write: '('.
	termsequence
		do:
			[:aterm | aterm printAsPrologOn: aStream scope: #asTerm in: env startAt: idx]
		separatedBy: [aStream write: ','].
	aStream write: ')'