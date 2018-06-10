private
createCallGraph
	
	| clauses |
	clauses := OrderedCollection new.
	clauseArray
		do:
			[:multArray | 
			multArray
				ifNotNil:
					[multArray
						do:
							[:clauseCollection | 
							clauseCollection
								ifNotNil: [clauseCollection do: [:clause | clauses add: clause]]]]].
	callGraph := CallGraph withClauses: clauses