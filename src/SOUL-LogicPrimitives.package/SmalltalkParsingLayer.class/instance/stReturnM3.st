template parsing
stReturnM3

stReturn(RBReturnNode(?expression),?tokens1,?tokens3) if 
	equals(?tokens1,<upArrow(?)|?tokens2>),stExpression(?expression,?tokens2,?tokens3)