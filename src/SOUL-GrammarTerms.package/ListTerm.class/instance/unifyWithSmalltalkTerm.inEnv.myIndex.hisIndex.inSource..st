unification
unifyWithSmalltalkTerm: stterm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource
	"this is handled in SmalltalkTerm itself"

	
	^stterm
		unifyWithListTerm: self
		inEnv: anEnv
		myIndex: hisIndex
		hisIndex: myIndex
		inSource: (inSource xor: true)