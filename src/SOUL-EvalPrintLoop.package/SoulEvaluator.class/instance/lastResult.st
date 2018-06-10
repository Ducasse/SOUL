private
lastResult
	
	| results |
	results := SoulFactory current makeResults onQuery: query.
	results add: lastResultCollection.
	^results