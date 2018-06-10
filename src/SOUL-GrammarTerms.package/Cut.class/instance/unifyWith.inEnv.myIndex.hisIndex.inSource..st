unification
unifyWith: aTerm inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource
	"double dispatch the unification of the term"

	
	^aTerm
		unifyWithCut: self
		inEnv: anEnv
		myIndex: targetIndex
		hisIndex: sourceIndex
		inSource: (inSource xor: true)