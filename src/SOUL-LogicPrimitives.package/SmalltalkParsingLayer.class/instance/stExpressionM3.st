template parsing
stExpressionM3

stExpression(?exp,?tokens1,?tokens2) if 
	stAssignment(?exp,?tokens1,?tokens2).
stExpression(?exp,?tokens1,?tokens2) if 
	stCascademessage(?exp,?tokens1,?tokens2)