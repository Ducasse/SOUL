unification
unifyWithQuotedCodeTerm: aQCTerm inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource
	
	^smalltalkValue source
		matchesRegex: (aQCTerm asSourceStringIn: anEnv startAt: targetIndex)