unification
unifyWithUppedObject: anObject inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource
	"I unify with another object if my downed versions are equal"

	
	^(self soulDownIn: anEnv startAt: myIndex)
		= (anObject soulDownIn: anEnv startAt: hisIndex)