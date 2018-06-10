evaluation
nextResult
	
	| result |
	result := SoulFactory current makeResults onQuery: query.
	result
		timeTaken:
			(Time millisecondsToRun: [lastResultCollection := ruleselector next]).
	result add: lastResultCollection.
	allResults add: lastResultCollection.
	allResults timeTaken: result timeTaken + allResults timeTaken.
	^result