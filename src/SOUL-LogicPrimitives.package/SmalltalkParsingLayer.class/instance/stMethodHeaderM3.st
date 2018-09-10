template parsing
stMethodHeaderM3

stMethodHeader(methodHeader(?selector,<>),?tokens1,?tokens2) if 
	stUnarySelector(?selector,?tokens1,?tokens2).
stMethodHeader(methodHeader(?selector,?args),?tokens1,?tokens2) if 
	stBinarySelector(methodHeader(?selector,?args),?tokens1,?tokens2).
stMethodHeader(methodHeader(?selector,?args),?tokens1,?tokens2) if 
	stKeywordSelector(methodHeader(?selector,?args),?tokens1,?tokens2).
stMethodHeader(methodHeader(?selector,?args),?tokens1,?tokens2) if 
	stTemplateSelector(methodHeader(?selector,?args),?tokens1,?tokens2)