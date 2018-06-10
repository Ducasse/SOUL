unification
unifyWithVarArgsCompoundTerm: aCompound inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource
	
	(aCompound isASTLinkedIn: anEnv startAt: targetIndex)
		ifTrue:
			[^self
				unifyWith: aCompound astLink
				inEnv: anEnv
				myIndex: sourceIndex
				hisIndex: targetIndex
				inSource: inSource]
		ifFalse:
			[^(self
				unifyWith: aCompound astLink
				inEnv: anEnv
				myIndex: sourceIndex
				hisIndex: targetIndex
				inSource: inSource)
				and:
					[smalltalkValue unifyWithVarArgsCompoundTerm: aCompound inEnv: anEnv
						myIndex: sourceIndex hisIndex: targetIndex inSource: inSource]]