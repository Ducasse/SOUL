private
assertRepresentationPrintsAndParsesSanely: representation
	
	| printedExpressionString reparsedRepresentation reprintedExpressionString |
	printedExpressionString := representation printString.
	reparsedRepresentation := SoulFactory current makeParser parse:
			printedExpressionString.
	reprintedExpressionString := reparsedRepresentation printString.
	self assert: printedExpressionString = reprintedExpressionString