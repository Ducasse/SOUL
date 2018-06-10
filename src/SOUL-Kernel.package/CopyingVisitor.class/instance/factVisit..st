visiting clauses
factVisit: aClause
	
	| copy |
	copy := SoulFactory current makeFact
		condition: (aClause condition accept: self)
		conclusion: (aClause conclusion accept: self).
	copy comment: aClause comment.
	^copy