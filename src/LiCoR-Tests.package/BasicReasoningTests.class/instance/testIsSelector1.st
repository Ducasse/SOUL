methods
testIsSelector1
	
	self processQuery:
			' if not(thisIsUnlikelyToEveryBeTheSelectorOfAMethod isSelector)'
		description:
			'The symbol #thisIsUnlikelyToEveryBeTheSelectorOfAMethod is not the selector of any method'.
	self processQuery: ' if #printOn: isSelector' description:
			'The symbol #printOn: is known to be a selector'