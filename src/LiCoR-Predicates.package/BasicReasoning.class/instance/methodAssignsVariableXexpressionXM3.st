method body
methodAssignsVariableXexpressionXM3

"Does the method ?Method contain an assignment to ?Variable  (temp or instance variable) with ?Expression as the rhs argument?"

?Method methodAssignsVariable: ?Variable expression: ?Expression if 
	?Method isMethod,?Tree isParseTreeOfMethod: ?Method,RBAssignmentNode(RBVariableNode(?Variable),?Expression) isStChildOf: ?Tree