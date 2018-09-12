*SOUL-Kernel
unifyWithVarArgsCompoundTerm: aCompound inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource
	
	| varargsmultiplicity |
	varargsmultiplicity := aCompound realmultiplicity.
	^(self functor
		unifyWith: aCompound functor
		inEnv: anEnv
		myIndex: sourceIndex
		hisIndex: targetIndex
		inSource: inSource) & (self multiplicity >= varargsmultiplicity)
		and:
			[varargsmultiplicity = 1
				ifTrue:
					[(self
						listTermFrom: 1
						to: self multiplicity)
						unifyWith: (aCompound termSequence terms at: 1)
						inEnv: anEnv
						myIndex: sourceIndex
						hisIndex: targetIndex
						inSource: inSource]
				ifFalse:
					[1
						to: varargsmultiplicity - 1
						do:
							[:index | 
							((aCompound termSequence terms at: index)
								unifyWith: (self reifiedSoulChildren at: index)
								inEnv: anEnv
								myIndex: targetIndex
								hisIndex: sourceIndex
								inSource: inSource not) ifFalse: [^false]].
					(self
						listTermFrom: varargsmultiplicity
						to: self multiplicity)
						unifyWith: (aCompound termSequence terms at: varargsmultiplicity)
						inEnv: anEnv
						myIndex: sourceIndex
						hisIndex: targetIndex
						inSource: inSource]]