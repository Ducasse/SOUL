template parsing
stKeywordsM3

stKeywords(<key(?keyword,?expression)>,?tokens1,?tokens3) if 
	stKeywordterminal(?keyword,?tokens1,?tokens2),stBinarymessage(?expression,?tokens2,?tokens3).
stKeywords(<key(?keyword,?expression)|?keywords>,?tokens1,?tokens4) if 
	stKeywordterminal(?keyword,?tokens1,?tokens2),stBinarymessage(?expression,?tokens2,?tokens3),stKeywords(?keywords,?tokens3,?tokens4)