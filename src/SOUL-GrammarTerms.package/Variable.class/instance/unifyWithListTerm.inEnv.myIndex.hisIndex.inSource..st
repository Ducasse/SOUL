unification
unifyWithListTerm: aList inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource
	"I unify with a compound by binding to it or unifying my value with it"

	
	| val |
	val := anEnv lookup: self startAt: myIndex.
	val isNil
		ifTrue:
			[anEnv bind: self to: aList startAt: myIndex valueStartAt: hisIndex.
			^true]
		ifFalse:
			[^val term
				unifyWithListTerm: aList
				inEnv: anEnv
				myIndex: val envIndex
				hisIndex: hisIndex
				inSource: inSource]