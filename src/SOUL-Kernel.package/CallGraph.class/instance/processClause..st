private
processClause: aClause
	
	aClause condition
		do: [:aTerm | self processTerm: aTerm fromClause: aClause]