unification
unifyWithCompoundTerm: aCompound inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource
	
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
					[smalltalkValue unifyWithCompoundTerm: aCompound inEnv: anEnv myIndex:
							sourceIndex hisIndex: targetIndex inSource: inSource]]