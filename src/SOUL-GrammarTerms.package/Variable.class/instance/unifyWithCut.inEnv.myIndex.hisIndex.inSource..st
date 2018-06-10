unification
unifyWithCut: aCut inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource
	"I unify with a cut by binding to it or by unifying it with my 
	value "

	
	| val |
	val := anEnv lookup: self startAt: sourceIndex.
	val isNil
		ifTrue:
			[anEnv bind: self to: aCut startAt: sourceIndex valueStartAt: targetIndex.
			^true]
		ifFalse:
			[^val term
				unifyWithCut: aCut
				inEnv: anEnv
				myIndex: val envIndex
				hisIndex: targetIndex
				inSource: inSource]