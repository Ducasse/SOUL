unification
unifyWithUnaryMessageFunctor: unaryFunctor inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource
	"transfered"

	
	^self message
		unifyWith: unaryFunctor message
		inEnv: anEnv
		myIndex: myIndex
		hisIndex: hisIndex
		inSource: inSource