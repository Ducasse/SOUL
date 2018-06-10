unification
unifyWithDelayedVariable: aVariable inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource
	"I unify with a delayed variable by binding myself to it or unifying  
	with it's value"

	
	| val |
	val := anEnv lookup: aVariable startAt: hisIndex.
	val isNil
		ifTrue:
			[anEnv bind: aVariable to: self startAt: hisIndex valueStartAt: myIndex.
			^true]
		ifFalse:
			[^val term
				unifyWithSmalltalkTerm: self
				inEnv: anEnv
				myIndex: val envIndex
				hisIndex: myIndex
				inSource: (inSource xor: true)]