unification
unifyWithAnnotatedTerm: aTerm inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource
	"Simply ignore the annotation part.
	Otherwise, crisp goals will not resolve against annotated rules."

	"^self
		unifyWith: aTerm transitiveTerm
		inEnv: anEnv
		myIndex: sourceIndex
		hisIndex: targetIndex
		inSource: inSource"

	
	^false