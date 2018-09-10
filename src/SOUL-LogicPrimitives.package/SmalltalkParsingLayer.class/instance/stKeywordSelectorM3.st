template parsing
stKeywordSelectorM3

stKeywordSelector(methodHeader(?selector,?args),?tokens1,?tokens3) if 
	stKeywordSelector2(?selectorList,?args,?tokens1,?tokens2),and({makeKeywordSelector(?selectorList,?selector)},equals(?tokens2,?tokens3))