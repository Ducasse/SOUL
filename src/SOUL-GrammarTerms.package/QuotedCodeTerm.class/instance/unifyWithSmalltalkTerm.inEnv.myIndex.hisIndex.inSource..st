unification
unifyWithSmalltalkTerm: aSTTerm inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource
	
	^(aSTTerm evaluateIn: anEnv startAt: targetIndex) soulUp
		unifyWithQuotedCodeTerm: self
		inEnv: anEnv
		myIndex: targetIndex
		hisIndex: sourceIndex
		inSource: inSource not