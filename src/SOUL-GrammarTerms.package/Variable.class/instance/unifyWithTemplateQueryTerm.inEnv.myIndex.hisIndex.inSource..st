unification
unifyWithTemplateQueryTerm: aTQCTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource
	
	| val |
	val := anEnv lookup: self.
	val isNil
		ifTrue:
			[anEnv bind: self to: aTQCTerm startAt: myIndex valueStartAt: hisIndex.
			^true]
		ifFalse:
			[^val term
				unifyWithTemplateQueryTerm: aTQCTerm
				inEnv: anEnv
				myIndex: val envIndex
				hisIndex: hisIndex
				inSource: inSource]