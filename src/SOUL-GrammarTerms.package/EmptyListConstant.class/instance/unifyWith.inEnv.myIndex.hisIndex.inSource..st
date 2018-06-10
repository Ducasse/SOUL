unification
unifyWith: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource
	
	^aTerm
		unifyWithEmptyListConstant: self
		inEnv: anEnv
		myIndex: hisIndex
		hisIndex: myIndex
		inSource: inSource not