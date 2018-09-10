template parsing
stKeywordSelector2M4

stKeywordSelector2(<?selector|?nextSelectors>,<?arg|?nextArgs>,?tokens1,?tokens4) if 
	stKeywordterminal(?selector,?tokens1,?tokens2),stVariable(?arg,?tokens2,?tokens3),stKeywordSelector2(?nextSelectors,?nextArgs,?tokens3,?tokens4).

stKeywordSelector2(<?selector>,<?arg>,?tokens1,?tokens3) if 
	stKeywordterminal(?selector,?tokens1,?tokens2),stVariable(?arg,?tokens2,?tokens3)