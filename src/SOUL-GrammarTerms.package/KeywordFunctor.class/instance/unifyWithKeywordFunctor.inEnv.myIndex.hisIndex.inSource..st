unification
unifyWithKeywordFunctor: otherKeyFunctor inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource
	
	self multiplicity = otherKeyFunctor multiplicity ifFalse: [^false].
	self keywords
		with: otherKeyFunctor keywords
		do:
			[:myKey :otherKey | 
			(myKey unifyWith: otherKey inEnv: anEnv myIndex: myIndex hisIndex: hisIndex
				inSource: inSource) ifFalse: [^false]].
	^true