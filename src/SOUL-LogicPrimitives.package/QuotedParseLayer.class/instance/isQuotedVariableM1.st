template basics
isQuotedVariableM1

"Check if it's a quoted variable."

?x isQuotedVariable if 
	[?x isSymbol],['MetaVar*' match: ?x]