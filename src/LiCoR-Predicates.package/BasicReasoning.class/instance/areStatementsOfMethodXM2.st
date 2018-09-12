method body
areStatementsOfMethodXM2

"Retrieve the ?Statements of a ?Method"

?Statements areStatementsOfMethod: ?Method if 
	?Method isMethod,RBMethodNode(?,?,RBSequenceNode(?,?Statements)) isParseTreeOfMethod: ?Method