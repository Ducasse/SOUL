unification
unifyWithCompoundTerm: aCompound inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource
	"a quotedCode unifies with a compound in the following way:
	{a b c d} <-> <a,b,c,d>
	{a ?b c ?d} <-> <a,?b,c,?d>(?b,?d)"

	
	| vars otherTerms |
	vars := self variables.
	vars size == aCompound multiplicity
		ifTrue:
			[otherTerms := aCompound termSequence terms.
			vars
				with: otherTerms
				do:
					[:myTerm :otherTerm | 
					(otherTerm
						unifyWith: myTerm
						inEnv: anEnv
						myIndex: hisIndex
						hisIndex: myIndex
						inSource: (inSource xor: true)) ifFalse: [^false]].
			^aCompound functor
				unifyWith:
					(SoulFactory current makeList
						termSequence:
							(TermSequence new terms: (content collect: [:each | each quotedCodeToList])))
				inEnv: anEnv
				myIndex: hisIndex
				hisIndex: myIndex
				inSource: (inSource xor: true)]
		ifFalse: [^false]