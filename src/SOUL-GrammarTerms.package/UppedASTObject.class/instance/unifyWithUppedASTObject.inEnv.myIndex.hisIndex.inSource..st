unification
unifyWithUppedASTObject: anObject inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource
	
	^smalltalkValue
		unifyWith: anObject smalltalkValue
		inEnv: anEnv
		myIndex: sourceIndex
		hisIndex: targetIndex
		inSource: inSource