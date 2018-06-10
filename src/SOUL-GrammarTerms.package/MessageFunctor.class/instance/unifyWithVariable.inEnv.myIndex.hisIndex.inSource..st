unification
unifyWithVariable: aVariable inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource
	
	^aVariable
		unifyWithMessageFunctor: self
		inEnv: anEnv
		myIndex: hisIndex
		hisIndex: myIndex
		inSource: inSource not