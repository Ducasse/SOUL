template parsing
stUnarymessageM3

stUnarymessage(?expression,?tokens1,?tokens2) if 
	stBasicexpression(?expression,?tokens1,?tokens2).
stUnarymessage(?result,?tokens1,?tokens3) if 
	stBasicexpression(?expression,?tokens1,?tokens2),stUnaries(?expression,?result,?tokens2,?tokens3).
stUnarymessage(RBMessageNode(?exp,?selector,?args),?tokens1,?tokens3) if 
	stBasicexpression(?exp,?tokens1,?tokens2),stTemplateSelector(methodHeader(?selector,?args),?tokens2,?tokens3)