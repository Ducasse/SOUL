unification
unifyWithUppedObject: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource
	
	^aTerm
		unifyWithUnaryMessageFunctor: self
		inEnv: anEnv
		myIndex: hisIndex
		hisIndex: myIndex
		inSource: (inSource xor: true)