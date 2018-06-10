unification
unifyWithCompoundTerm: aCompound inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource
	"unify a compound with a compound => if the arities are the  
	same and the functors unify, then recursively unify the subterms"

	
	| otherTermSequence myAst hisAst |
	(((myAst := astlink soulDownIn: anEnv startAt: myIndex) isKindOf: Variable)
		not
		and:
			[((hisAst := aCompound astLink soulDownIn: anEnv startAt: hisIndex)
				isKindOf: Variable) not])
		ifTrue:
			[^myAst unifyWith: hisAst inEnv: anEnv myIndex: myIndex hisIndex: hisIndex
				inSource: inSource]
		ifFalse:
			[self multiplicity = aCompound multiplicity
				&
					(self functor
						unifyWith: aCompound functor
						inEnv: anEnv
						myIndex: myIndex
						hisIndex: hisIndex
						inSource: inSource)
				ifTrue:
					[(astlink
						unifyWith: aCompound astLink
						inEnv: anEnv
						myIndex: myIndex
						hisIndex: hisIndex
						inSource: inSource) ifFalse: [^false].
					otherTermSequence := aCompound termSequence.
					termsequence terms
						with: otherTermSequence terms
						do:
							[:myTerm :otherTerm | 
							(myTerm unifyWith: otherTerm inEnv: anEnv myIndex: myIndex hisIndex:
									hisIndex inSource: inSource) ifFalse: [^false]].
					^true]
				ifFalse: [^false]]