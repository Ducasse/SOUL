unification
unifyWithAnnotatedTerm: aTerm inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource
	
	^(self term
		unifyWith: aTerm term
		inEnv: anEnv
		myIndex: sourceIndex
		hisIndex: targetIndex
		inSource: inSource)
		and:
			[self annotation
				unifyWith: aTerm annotation
				inEnv: anEnv
				myIndex: sourceIndex
				hisIndex: targetIndex
				inSource: inSource]