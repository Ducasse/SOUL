unification
unifyWithCompoundTerm: aCompound inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource
	"unify a compound with a compound => if the arities are the  
	same and the functors unify, then recursively unify the subterms"

	
	| otherTermSequence |
	self multiplicity = aCompound multiplicity
		&
			(self functor
				unifyWith: aCompound functor
				inEnv: anEnv
				myIndex: myIndex
				hisIndex: hisIndex
				inSource: inSource)
		ifTrue:
			[otherTermSequence := aCompound termSequence.
			termsequence terms
				with: otherTermSequence terms
				do:
					[:myTerm :otherTerm | 
					(myTerm unifyWith: otherTerm inEnv: anEnv myIndex: myIndex hisIndex:
							hisIndex inSource: inSource) ifFalse: [^false]].
			^true]
		ifFalse: [^false]