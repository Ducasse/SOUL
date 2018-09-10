template parsing
stStatementList2M3

stStatementList2(<?statement|?nextStatements>,?tokens1,?tokens4) if 
	stStatement(?statement,?tokens1,?tokens2),equals(?tokens2,<period(?)|?tokens3>),stStatementList2(?nextStatements,?tokens3,?tokens4).
stStatementList2(<?statement>,?tokens1,?tokens2) if 
	stStatement(?statement,?tokens1,?tokens2)