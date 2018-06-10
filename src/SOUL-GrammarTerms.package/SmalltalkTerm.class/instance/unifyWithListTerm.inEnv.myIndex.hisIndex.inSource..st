unification
unifyWithListTerm: listTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource
	"I unify with an object if my result of evaluation unifies with this  
	object"

	
	^(self evaluateIn: anEnv startAt: myIndex) soulUp unifyWithListTerm:
			listTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource:
			inSource