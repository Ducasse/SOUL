unification
unifyWith: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: aBool
	
	^aTerm
		unifyWithDelayedVariable: self
		inEnv: anEnv
		myIndex: hisIndex
		hisIndex: myIndex
		inSource: aBool not