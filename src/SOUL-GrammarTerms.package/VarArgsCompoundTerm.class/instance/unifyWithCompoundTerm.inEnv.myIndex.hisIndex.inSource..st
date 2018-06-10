unification
unifyWithCompoundTerm: aCompound inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource
	"unify a compound with a VarArgscompound => if the functors unify and our multiplicity is smaller or equal to the normal compound's multiplicity, then we unify the subterms and our last subterm unifies with a list of the remaining subterms of the normal compound"

	
	| otherTermSequence newListTerm |
	(self functor
		unifyWith: aCompound functor
		inEnv: anEnv
		myIndex: myIndex
		hisIndex: hisIndex
		inSource: inSource) & (aCompound multiplicity >= self realmultiplicity)
		ifTrue:
			[otherTermSequence := aCompound termSequence.
			self realmultiplicity = 1
				ifTrue:
					[newListTerm := SoulFactory current makeList
						termSequence: aCompound termSequence.
					(newListTerm
						unifyWith: (termsequence terms at: 1)
						inEnv: anEnv
						myIndex: hisIndex
						hisIndex: myIndex
						inSource: (inSource xor: true)) ifFalse: [^false]]
				ifFalse:
					[1
						to: self realmultiplicity - 1
						do:
							[:index | 
							((otherTermSequence terms at: index)
								unifyWith: (termsequence terms at: index)
								inEnv: anEnv
								myIndex: hisIndex
								hisIndex: myIndex
								inSource: (inSource xor: true)) ifFalse: [^false]].
					(SoulFactory current makeList
						termSequence:
							(TermSequence
								terms:
									(aCompound termSequence terms
										copyFrom: self realmultiplicity
										to: aCompound multiplicity)))
						unifyWith: (termsequence terms at: self realmultiplicity)
						inEnv: anEnv
						myIndex: hisIndex
						hisIndex: myIndex
						inSource: (inSource xor: true)].
			^true]
		ifFalse: [^false]