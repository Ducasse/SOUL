unification
unifyWithUppedObject: anObject inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource
	
	^anObject
		unifyWithMessageFunctor: self
		inEnv: anEnv
		myIndex: targetIndex
		hisIndex: sourceIndex
		inSource: (inSource xor: true)