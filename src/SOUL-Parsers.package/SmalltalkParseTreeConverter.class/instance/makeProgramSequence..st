private
makeProgramSequence: aClause
	
	^ProgramSequence
		clauses: (OrderedCollection with: (self makeFact: aClause))