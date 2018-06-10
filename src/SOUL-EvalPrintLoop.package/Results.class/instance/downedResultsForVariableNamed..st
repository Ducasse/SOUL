public-access
downedResultsForVariableNamed: aString
	
	^(self resultsForVariableNamed: aString)
		collect:
			[:each | 
			each
				soulDownIn: Environment new
				startAt: 0]