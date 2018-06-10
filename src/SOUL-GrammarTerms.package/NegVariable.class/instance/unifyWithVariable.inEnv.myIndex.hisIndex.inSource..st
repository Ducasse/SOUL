unification
unifyWithVariable: aVariable inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource
	
	| val val2 |
	val := anEnv lookup: self startAt: myIndex.
	val isNil
		ifTrue:
			[val2 := anEnv lookup: aVariable startAt: hisIndex.
			val2 isNil
				ifTrue:
					[aVariable ~~ self
						ifTrue:
							[inSource
								ifTrue:
									[anEnv
										bind: self asNormalVariable
										to: aVariable
										startAt: myIndex
										valueStartAt: hisIndex]
								ifFalse:
									[anEnv
										bind: aVariable
										to: self asNormalVariable
										startAt: hisIndex
										valueStartAt: myIndex]].
					^true]
				ifFalse:
					[^val2 term
						unifyWithNegVariable: self
						inEnv: anEnv
						myIndex: val2 envIndex
						hisIndex: myIndex
						inSource: (inSource xor: true)]]
		ifFalse:
			[^val term
				unifyWithVariable: aVariable
				inEnv: anEnv
				myIndex: val envIndex
				hisIndex: hisIndex
				inSource: inSource]