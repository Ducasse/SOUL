unification
unifyWithUppedASTObject: anObject inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource
	
	^anObject
		unifyWithVarArgsCompoundTerm: self
		inEnv: anEnv
		myIndex: targetIndex
		hisIndex: sourceIndex
		inSource: (inSource xor: true)