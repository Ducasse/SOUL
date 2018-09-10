template parsing
stStatementM3

stStatement(?statement,?tokens1,?tokens2) if 
	stReturn(?statement,?tokens1,?tokens2).
stStatement(?statement,?tokens1,?tokens2) if 
	stExpression(?statement,?tokens1,?tokens2)