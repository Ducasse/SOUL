unification
unifyWithVariable: aVariable inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource
	"a quotedCode unifies with a variable by binding to this variable or 
	unifying with it's binding"

	
	| val |
	val := anEnv lookup: aVariable startAt: hisIndex.
	val isNil
		ifTrue:
			[anEnv bind: aVariable to: self startAt: hisIndex valueStartAt: myIndex.
			^true]
		ifFalse:
			[^val term
				unifyWithQuotedCodeTerm: self
				inEnv: anEnv
				myIndex: val envIndex
				hisIndex: myIndex
				inSource: (inSource xor: true)]