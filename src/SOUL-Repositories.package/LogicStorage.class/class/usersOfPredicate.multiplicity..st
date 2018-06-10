private
usersOfPredicate: pred multiplicity: mult
	
	^self gatherClauses
		select: [:clause | clause usesPredicate: pred multiplicity: mult]