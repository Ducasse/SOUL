unification
unifyWithAnnotatedTerm: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource
	"I unify with a fuzzy term by binding to it or unifying my value with it"

	
	| val |
	val := anEnv lookup: self startAt: myIndex.
	val isNil
		ifTrue:
			[anEnv bind: self to: aTerm startAt: myIndex valueStartAt: hisIndex.
			^true]
		ifFalse:
			[^val term
				unifyWithAnnotatedTerm: aTerm
				inEnv: anEnv
				myIndex: val envIndex
				hisIndex: hisIndex
				inSource: inSource]