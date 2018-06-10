private
processTerm: aTerm fromClause: aClause
	
	| functor funcMul coll |
	aTerm isCompoundTerm
		ifTrue:
			[functor := aTerm functor asString.
			(#('not' 'or' 'and') contains: [:x | x = functor])
				ifTrue: [^self processComplexTerm: aTerm fromClause: aClause].
			funcMul := functor , aTerm multiplicity asString.
			coll := nodeMapping at: aClause.
			coll
				addAll:
					(clauseNames
						at: funcMul
						ifAbsent:
							[Transcript show: 'ignored unknown term in CallGraph: ' , funcMul.
							OrderedCollection new])]