private
makeFact: aClause
	
	^Fact
		condition: TermSequence new
		conclusion: aClause