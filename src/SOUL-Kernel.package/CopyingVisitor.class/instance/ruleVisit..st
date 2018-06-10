visiting clauses
ruleVisit: aClause
	
	| copy |
	copy := SoulFactory current makeRule
		condition: (aClause condition accept: self)
		conclusion: (aClause conclusion accept: self).
	copy comment: aClause comment.
	^copy