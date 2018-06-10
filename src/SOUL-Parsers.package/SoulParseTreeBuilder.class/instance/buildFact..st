building SOUL
buildFact: aTerm
	
	^(SoulFactory current makeFact conclusion: aTerm)
		comment: self lastComments;
		yourself