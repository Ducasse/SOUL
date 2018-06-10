unification
unifyWithSmalltalkTerm: anSTTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource
	
	| val |
	val := anEnv lookup: self startAt: myIndex.
	val isNil
		ifTrue:
			[anEnv
				bind: self
				to: (anSTTerm evaluateIn: anEnv startAt: hisIndex) soulUp
				startAt: myIndex
				valueStartAt: hisIndex.
			^true]
		ifFalse:
			[^val term
				unifyWithSmalltalkTerm: anSTTerm
				inEnv: anEnv
				myIndex: val envIndex
				hisIndex: hisIndex
				inSource: inSource]