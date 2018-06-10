visiting terms
nativeClauseVisit: aNativeClause
	
	| variables |
	variables := aNativeClause variables.
	aNativeClause header do: [:el | el accept: self].
	variables do: [:var | doBlock value: var]