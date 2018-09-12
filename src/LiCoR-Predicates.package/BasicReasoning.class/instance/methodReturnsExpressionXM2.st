method body
methodReturnsExpressionXM2

"Does this ?Method have a return expression ?Expression"

?Method methodReturnsExpression: ?Expression if 
	?Method isMethod,?Tree isParseTreeOfMethod: ?Method,RBReturnNode(?Expression) isStChildOf: ?Tree