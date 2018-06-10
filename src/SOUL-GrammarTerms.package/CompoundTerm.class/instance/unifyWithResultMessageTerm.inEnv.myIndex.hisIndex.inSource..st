unification
unifyWithResultMessageTerm: aRM inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource
	"ResultMessageTerm implements this"

	
	^aRM
		unifyWithCompoundTerm: self
		inEnv: anEnv
		myIndex: targetIndex
		hisIndex: sourceIndex
		inSource: inSource not