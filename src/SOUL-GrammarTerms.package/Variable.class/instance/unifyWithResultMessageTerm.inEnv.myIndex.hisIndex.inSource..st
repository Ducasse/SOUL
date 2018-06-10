unification
unifyWithResultMessageTerm: aResultMessage inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource
	
	| val |
	val := anEnv lookup: self startAt: myIndex.
	val isNil
		ifTrue:
			[anEnv bind: self to: aResultMessage startAt: myIndex valueStartAt:
					hisIndex.
			^true]
		ifFalse:
			[^val term
				unifyWithResultMessageTerm: aResultMessage
				inEnv: anEnv
				myIndex: val envIndex
				hisIndex: hisIndex
				inSource: inSource]