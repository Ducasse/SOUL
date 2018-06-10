unification
unifyWithVariable: aVariable inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource
	
	^aVariable
		unifyWithNativeClause: self
		inEnv: anEnv
		myIndex: targetIndex
		hisIndex: sourceIndex
		inSource: (inSource xor: true)