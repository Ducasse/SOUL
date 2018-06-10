unification
unifyWith: otherTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource
	
	^otherTerm
		unifyWithKeywordFunctor: self
		inEnv: anEnv
		myIndex: hisIndex
		hisIndex: myIndex
		inSource: inSource not