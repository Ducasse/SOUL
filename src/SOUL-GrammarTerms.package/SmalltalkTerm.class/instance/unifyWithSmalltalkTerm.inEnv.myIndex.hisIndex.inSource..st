unification
unifyWithSmalltalkTerm: anSTTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource
	"I unify with another SmallTalkTerm if my result and his result unify."

	
	^(self evaluateIn: anEnv startAt: myIndex) soulUp unifyWithSmalltalkTerm:
			anSTTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource:
			inSource