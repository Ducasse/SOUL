unification
unifyWith: otherTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource
	
	^otherTerm unifyWithMessageFunctor: self inEnv: anEnv myIndex: hisIndex
		hisIndex: myIndex inSource: inSource