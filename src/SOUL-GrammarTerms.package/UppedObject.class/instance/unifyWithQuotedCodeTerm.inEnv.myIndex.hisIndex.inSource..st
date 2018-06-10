unification
unifyWithQuotedCodeTerm: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource
	
	^aTerm
		unifyWithUppedObject: self
		inEnv: anEnv
		myIndex: hisIndex
		hisIndex: myIndex
		inSource: inSource not