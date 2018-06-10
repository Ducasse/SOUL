private
processComplexTerm: aTerm fromClause: aClause
	
	aTerm termSequence
		do: [:term | self processTerm: term fromClause: aClause]