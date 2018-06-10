clause generation
generateRule: aString definitionRepository: aRepository
	
	| newRule |
	newRule := (SoulFactory current makeParser
		parse: aString
		onError: [:a :b | self error: 'parse error in generated regexrule'])
		clauses first.
	generatedClauses add: newRule.
	^newRule