printing
prettyPrintConclusionOn: aStream
	
	| subterms |
	conclusion functor prettyPrintAsFunctorOn: aStream scope: #asClause.
	subterms := conclusion termSequence terms.
	subterms size > 2
		ifTrue:
			[aStream write: '('.
			(1 to: subterms size - 2)
				do: [:i | (subterms at: i) prettyPrintOn: aStream scope: #asTerm]
				separatedBy: [aStream write: ','].
			aStream write: ')']