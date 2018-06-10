unification
unifyWithSmalltalkTerm: anSTTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource
	"I unify with a SmallTalkTerm if the result of this smalltalkterm unifies 
	with me"

	
	^self
		unifyWithUppedObject:
			(anSTTerm soulDownIn: anEnv startAt: hisIndex) soulUp
		inEnv: anEnv
		myIndex: myIndex
		hisIndex: hisIndex
		inSource: inSource