unification
unifyWithVariable: aVariable inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource
	"see comment in AbstractTerm"

	
	| val val2 |
	val := anEnv lookup: self startAt: myIndex.
	val isNil
		ifTrue:
			[val2 := anEnv lookup: aVariable startAt: hisIndex.
			val2 isNil
				ifTrue:
					[inSource
						ifTrue:
							[anEnv bind: self to: aVariable startAt: myIndex valueStartAt: hisIndex]
						ifFalse:
							[anEnv bind: aVariable to: self startAt: hisIndex valueStartAt: myIndex].
					^true]
				ifFalse:
					[^val2 term
						unifyWithDelayedVariable: self
						inEnv: anEnv
						myIndex: val2 envIndex
						hisIndex: myIndex
						inSource: (inSource xor: true)]]
		ifFalse:
			[^val term
				unifyWithDelayedVariable: aVariable
				inEnv: anEnv
				myIndex: val envIndex
				hisIndex: hisIndex
				inSource: inSource]