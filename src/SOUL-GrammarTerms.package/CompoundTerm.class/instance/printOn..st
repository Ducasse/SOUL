printing
printOn: aStream
	"see comment in AbstractTerm"

	
	functor printAsFunctorOn: aStream.
	aStream write: '('.
	termsequence
		do: [:aterm | aterm printOn: aStream]
		separatedBy: [aStream write: ','].
	aStream write: ')'