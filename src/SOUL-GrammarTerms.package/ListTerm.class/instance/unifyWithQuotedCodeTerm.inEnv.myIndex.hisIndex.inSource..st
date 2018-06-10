unification
unifyWithQuotedCodeTerm: aQCTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource
	"a compound unifies with a quotedCode"

	
	^aQCTerm
		unifyWithListTerm: self
		inEnv: anEnv
		myIndex: hisIndex
		hisIndex: myIndex
		inSource: (inSource xor: true)