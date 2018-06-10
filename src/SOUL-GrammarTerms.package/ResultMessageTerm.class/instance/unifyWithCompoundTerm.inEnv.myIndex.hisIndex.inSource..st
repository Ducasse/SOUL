unification
unifyWithCompoundTerm: aCompound inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource
	
	^(self result
		unifyWith: true soulUp
		inEnv: anEnv
		myIndex: myIndex
		hisIndex: hisIndex
		inSource: inSource)
		and:
			[self message unifyWithCompoundTerm: aCompound inEnv: anEnv myIndex:
					myIndex hisIndex: hisIndex inSource: inSource]