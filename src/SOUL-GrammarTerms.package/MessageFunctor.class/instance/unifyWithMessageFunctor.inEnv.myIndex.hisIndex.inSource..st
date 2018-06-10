unification
unifyWithMessageFunctor: otherMessageFunctor inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource
	
	self multiplicity = otherMessageFunctor multiplicity ifFalse: [^false].
	self keywords
		with: otherMessageFunctor keywords
		do:
			[:myKey :otherKey | 
			(myKey unifyWith: otherKey inEnv: anEnv myIndex: myIndex hisIndex: hisIndex
				inSource: inSource) ifFalse: [^false]].
	^true