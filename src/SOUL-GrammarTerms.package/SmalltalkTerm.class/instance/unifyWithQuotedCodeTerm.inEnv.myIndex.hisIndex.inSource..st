unification
unifyWithQuotedCodeTerm: aQCTerm inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource
	
	^(self evaluateIn: anEnv startAt: sourceIndex) soulUp
		unifyWithQuotedCodeTerm: aQCTerm inEnv: anEnv myIndex: sourceIndex
		hisIndex: targetIndex inSource: inSource