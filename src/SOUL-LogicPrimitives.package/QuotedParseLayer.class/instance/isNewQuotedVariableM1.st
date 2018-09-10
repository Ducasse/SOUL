template basics
isNewQuotedVariableM1

"Create a new quoted variable. This is useful if a new unique quoted variable needs to be created"

?x isNewQuotedVariable if 
	var(?x),?x equals: [('MetaVar' , SoulFactory uniqueName) asSymbol]