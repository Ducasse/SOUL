printing
printConclusionOn: aStream
	
	| subterms |
	conclusion functor printOn: aStream.
	subterms := conclusion termSequence terms.
	subterms size > 2
		ifTrue:
			[aStream write: '('.
			(1 to: subterms size - 2)
				do: [:i | (subterms at: i) printOn: aStream]
				separatedBy: [aStream write: ','].
			aStream write: ')']