unification
unifyWithPosVariable: aVariable inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource
	"unify this term with a positive variable, standard is as with a normal variable"

	
	^self unifyWithVariable: aVariable inEnv: anEnv myIndex: sourceIndex
		hisIndex: targetIndex inSource: inSource