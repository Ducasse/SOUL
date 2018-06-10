unification
unifyWithEmptyListConstant: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource
	
	^(self evaluateIn: anEnv startAt: myIndex) soulUp
		unifyWithEmptyListConstant: aTerm inEnv: anEnv myIndex: myIndex hisIndex:
			hisIndex inSource: inSource