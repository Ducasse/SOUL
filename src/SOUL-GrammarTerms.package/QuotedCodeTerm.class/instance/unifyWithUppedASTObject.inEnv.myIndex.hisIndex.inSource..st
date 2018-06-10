unification
unifyWithUppedASTObject: anObject inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource
	
	^anObject unifyWithQuotedCodeTerm: self inEnv: anEnv myIndex: targetIndex
		hisIndex: sourceIndex inSource: inSource