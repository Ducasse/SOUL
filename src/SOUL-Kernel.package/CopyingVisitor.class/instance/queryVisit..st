visiting clauses
queryVisit: aClause
	
	| copy |
	copy := SoulFactory current makeQuery
		condition: (aClause condition accept: self).
	copy comment: aClause comment.
	^copy