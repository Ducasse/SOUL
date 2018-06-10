unification
unifyWithDelayedVariable: aVariable inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource
	"standard behaviour of unification with a delayedvariable is the same as with a normal variable"

	
	^self unifyWithVariable: aVariable inEnv: anEnv myIndex: sourceIndex
		hisIndex: targetIndex inSource: inSource