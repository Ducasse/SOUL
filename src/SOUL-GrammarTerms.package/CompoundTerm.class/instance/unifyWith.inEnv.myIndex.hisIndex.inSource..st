unification
unifyWith: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource
	"see comment in AbstractTerm"

	
	^aTerm
		unifyWithCompoundTerm: self
		inEnv: anEnv
		myIndex: hisIndex
		hisIndex: myIndex
		inSource: (inSource xor: true)