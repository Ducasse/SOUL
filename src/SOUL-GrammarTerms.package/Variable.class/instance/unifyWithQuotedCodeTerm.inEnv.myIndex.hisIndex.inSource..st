unification
unifyWithQuotedCodeTerm: aQCTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource
	
	| val |
	val := anEnv lookup: self startAt: myIndex.
	val isNil
		ifTrue:
			[anEnv bind: self to: aQCTerm startAt: myIndex valueStartAt: hisIndex.
			^true]
		ifFalse:
			[^val term
				unifyWithQuotedCodeTerm: aQCTerm
				inEnv: anEnv
				myIndex: val envIndex
				hisIndex: hisIndex
				inSource: inSource]