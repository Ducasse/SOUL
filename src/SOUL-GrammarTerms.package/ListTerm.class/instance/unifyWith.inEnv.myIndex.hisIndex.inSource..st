unification
unifyWith: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource
	"see comment in AbstractTerm"

	
	^aTerm
		unifyWithListTerm: self
		inEnv: anEnv
		myIndex: hisIndex
		hisIndex: myIndex
		inSource: inSource not