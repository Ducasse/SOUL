unification
unifyWithPosVariable: aVariable inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource
	
	| val |
	"transferred"

	val := anEnv lookup: self startAt: myIndex.
	val isNil
		ifTrue: [^false]
		ifFalse:
			[^val term
				unifyWithPosVariable: aVariable
				inEnv: anEnv
				myIndex: val envIndex
				hisIndex: hisIndex
				inSource: inSource]