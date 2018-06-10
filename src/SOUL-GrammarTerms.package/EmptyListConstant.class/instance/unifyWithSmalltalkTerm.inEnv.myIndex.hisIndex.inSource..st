unification
unifyWithSmalltalkTerm: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource
	
	^aTerm unifyWithEmptyListConstant: aTerm inEnv: anEnv myIndex: hisIndex
		hisIndex: myIndex inSource: inSource