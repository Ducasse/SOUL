template parsing
stBasicexpressionM3

stBasicexpression(?result,?tokens1,?tokens2) if 
	stLiteral(?result,?tokens1,?tokens2).
stBasicexpression(?result,?tokens1,?tokens2) if 
	stVariable(?result,?tokens1,?tokens2).
stBasicexpression(?exp,?tokens1,?tokens2) if 
	stBlock(?exp,?tokens1,?tokens2).
stBasicexpression(?var,?tokens1,?tokens2) if 
	soulvariable(?var,?tokens1,?tokens2)