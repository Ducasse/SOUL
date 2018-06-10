printing
printAsPrologOn: aStream scope: id in: env startAt: idx
	
	messageTerm functor printAsPrologFunctorOn: aStream scope: #asTerm in: env
		startAt: idx.
	aStream write: '('.
	messageTerm termSequence printAsPrologOn: aStream scope: #asTerm in: env
		startAt: idx.
	aStream write: ')'