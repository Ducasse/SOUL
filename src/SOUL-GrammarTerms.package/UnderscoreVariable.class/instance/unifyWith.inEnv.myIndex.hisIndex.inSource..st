unification
unifyWith: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource
	"I unify with everything"

	
	^aTerm unifyWithUnderscoreVariable: self inEnv: anEnv myIndex: myIndex
		hisIndex: hisIndex inSource: inSource