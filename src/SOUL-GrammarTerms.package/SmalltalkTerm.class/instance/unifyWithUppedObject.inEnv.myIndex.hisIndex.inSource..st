unification
unifyWithUppedObject: anObject inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource
	"I unify with an object if my result of evaluation unifies with this  
	object"

	
	^(self evaluateIn: anEnv startAt: myIndex) soulUp unifyWithUppedObject:
			anObject inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource:
			inSource