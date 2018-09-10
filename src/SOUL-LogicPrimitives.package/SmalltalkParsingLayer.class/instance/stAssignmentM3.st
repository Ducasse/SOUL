template parsing
stAssignmentM3

stAssignment(RBAssignmentNode(RBVariableNode(?name),?expression),?tokens1,?tokens3) if 
	equals(?tokens1,<word(?name),colon(?),binary([#=])|?tokens2>),stExpression(?expression,?tokens2,?tokens3).
stAssignment(RBAssignmentNode(RBVariableNode(?soulvar),?expression),?tokens1,?tokens4) if 
	soulvariable(?soulvar,?tokens1,?tokens2),equals(?tokens2,<colon(?),binary([#=])|?tokens3>),stExpression(?expression,?tokens3,?tokens4)