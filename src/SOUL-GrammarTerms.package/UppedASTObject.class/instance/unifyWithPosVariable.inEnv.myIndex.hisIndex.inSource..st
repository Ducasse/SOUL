unification
unifyWithPosVariable: aVariable inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource
	"we group all unfication with variables in the Variable class"

	
	^aVariable
		unifyWithUppedASTObject: self
		inEnv: anEnv
		myIndex: hisIndex
		hisIndex: myIndex
		inSource: (inSource xor: true)