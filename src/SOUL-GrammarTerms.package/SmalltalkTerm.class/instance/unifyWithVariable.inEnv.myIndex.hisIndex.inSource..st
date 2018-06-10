unification
unifyWithVariable: aVariable inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource
	"I unify with a variable by binding my value to it or unifying with it's 
	value"

	
	^self unifyWith: aVariable inEnv: anEnv myIndex: myIndex hisIndex:
			hisIndex inSource: inSource