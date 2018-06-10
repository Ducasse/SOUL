unification
unifyWithSmalltalkTerm: anSTTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource
	"see comment in AbstractTerm"

	
	| val |
	val := anEnv lookup: self startAt: myIndex.
	val isNil
		ifTrue:
			[anEnv bind: self to: anSTTerm startAt: myIndex valueStartAt: hisIndex.
			^true]
		ifFalse:
			[^val term
				unifyWithSmalltalkTerm: anSTTerm
				inEnv: anEnv
				myIndex: val envIndex
				hisIndex: hisIndex
				inSource: inSource]