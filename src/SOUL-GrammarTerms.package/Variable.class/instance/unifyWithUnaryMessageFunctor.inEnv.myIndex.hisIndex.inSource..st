unification
unifyWithUnaryMessageFunctor: unaryMessageFunctor inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource
	
	| val |
	val := anEnv lookup: self startAt: myIndex.
	val isNil
		ifTrue:
			[anEnv bind: self to: unaryMessageFunctor startAt: myIndex valueStartAt:
					hisIndex.
			^true]
		ifFalse:
			[^val term
				unifyWithUnaryMessageFunctor: unaryMessageFunctor
				inEnv: anEnv
				myIndex: val envIndex
				hisIndex: hisIndex
				inSource: inSource]