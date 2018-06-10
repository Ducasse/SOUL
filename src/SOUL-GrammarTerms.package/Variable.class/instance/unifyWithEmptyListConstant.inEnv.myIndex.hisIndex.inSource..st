unification
unifyWithEmptyListConstant: anObject inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource
	"I unify with an object by binding to it or by unifying it with my 
	value "

	
	| val |
	val := anEnv lookup: self startAt: myIndex.
	val isNil
		ifTrue:
			[anEnv bind: self to: anObject startAt: myIndex valueStartAt: hisIndex.
			^true]
		ifFalse:
			[^val term
				unifyWithEmptyListConstant: anObject
				inEnv: anEnv
				myIndex: val envIndex
				hisIndex: hisIndex
				inSource: inSource]