template parsing
stStatementListM3

stStatementList(?var,?tokens1,?tokens2) if 
	soulvariable(?var,?tokens1,?tokens2).
stStatementList(?statements,?tokens1,?tokens2) if 
	stStatementList2(?statements,?tokens1,?tokens2)