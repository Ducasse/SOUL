visiting clauses
nativeClauseVisit: aClause
	
	^aClause class newWith: (aClause header accept: self)