method body
isTemporaryVariableOfMethodXM2

"Retrieve the temporary variables of a ?Method"

?Variable isTemporaryVariableOfMethod: ?Method if 
	RBMethodNode(?,?,?body) isParseTreeOfMethod: ?Method,[?body allTemporaryVariables] contains: ?Variable