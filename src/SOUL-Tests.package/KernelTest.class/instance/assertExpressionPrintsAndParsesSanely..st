private
assertExpressionPrintsAndParsesSanely: soulExpressionString
	
	| representation |
	representation := SoulFactory current makeParser parse: soulExpressionString.
	self assertRepresentationPrintsAndParsesSanely: representation