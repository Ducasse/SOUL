unification
unifyWithResultMessageTerm: aRM inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource
	^(messageTerm
		unifyWith: aRM message
		inEnv: anEnv
		myIndex: sourceIndex
		hisIndex: targetIndex
		inSource: inSource)
		and:
			[resultTerm
				unifyWith: aRM result
				inEnv: anEnv
				myIndex: sourceIndex
				hisIndex: targetIndex
				inSource: inSource]