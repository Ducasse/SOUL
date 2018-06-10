unification
unifyWith: aTerm inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource
	
	^aTerm
		unifyWithNativeClause: self
		inEnv: anEnv
		myIndex: targetIndex
		hisIndex: sourceIndex
		inSource: (inSource xor: true)