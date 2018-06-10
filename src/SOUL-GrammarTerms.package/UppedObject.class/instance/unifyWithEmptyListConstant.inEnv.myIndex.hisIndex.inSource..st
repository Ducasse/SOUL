unification
unifyWithEmptyListConstant: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource
	
	^(smalltalkValue isKindOf: SequenceableCollection)
		and: [smalltalkValue isEmpty]