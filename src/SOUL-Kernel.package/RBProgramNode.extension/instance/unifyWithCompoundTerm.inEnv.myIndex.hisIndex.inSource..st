*SOUL-Kernel
unifyWithCompoundTerm: aCompound inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource
	
	^(self functor
		unifyWith: aCompound functor
		inEnv: anEnv
		myIndex: sourceIndex
		hisIndex: targetIndex
		inSource: inSource) & (self multiplicity = aCompound multiplicity)
		and:
			[aCompound termSequence terms
				doWithIndex:
					[:otherTerm :i | 
					(otherTerm isKindOf: UnderscoreVariable)
						ifFalse:
							[((self cachedSoulChildren at: i) unifyWith: otherTerm inEnv: anEnv
								myIndex: sourceIndex hisIndex: targetIndex inSource: inSource)
								ifFalse: [^false]]].
			true]