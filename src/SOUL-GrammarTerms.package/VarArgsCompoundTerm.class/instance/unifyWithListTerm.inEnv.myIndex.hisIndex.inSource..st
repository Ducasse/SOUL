unification
unifyWithListTerm: aListTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource
	
	| otherTermSequence newListTerm collection |
	collection := aListTerm collectIn: anEnv startAt: hisIndex.
	(self functor
		unifyWith: aListTerm functor
		inEnv: anEnv
		myIndex: myIndex
		hisIndex: hisIndex
		inSource: inSource) & (collection size >= self realmultiplicity)
		ifTrue:
			[otherTermSequence := TermSequence
				terms: (collection collect: [:t | t soulUp]).
			self realmultiplicity = 1
				ifTrue:
					[newListTerm := SoulFactory current makeList termSequence: otherTermSequence.
					newListTerm
						unifyWith: (termsequence terms at: 1)
						inEnv: anEnv
						myIndex: hisIndex
						hisIndex: myIndex
						inSource: (inSource xor: true)]
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
									(collection
										copyFrom: self realmultiplicity
										to: collection size)))
						unifyWith: (termsequence terms at: self realmultiplicity)
						inEnv: anEnv
						myIndex: hisIndex
						hisIndex: myIndex
						inSource: (inSource xor: true)].
			^true]
		ifFalse: [^false]