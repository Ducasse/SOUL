private
allClausesWith: aMultiplicity
	"return all clauses with a specific multiplicity"

	
	| resultClauses clauses |
	resultClauses := OrderedCollection new.
	clauseArray
		do:
			[:multArray | 
			multArray == nil
				ifFalse:
					[clauses := multArray at: aMultiplicity.
					clauses == nil ifFalse: [resultClauses addAll: clauses]]].
	^resultClauses