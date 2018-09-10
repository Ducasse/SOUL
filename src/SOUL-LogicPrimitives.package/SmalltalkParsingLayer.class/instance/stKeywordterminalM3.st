template parsing
stKeywordterminalM3

stKeywordterminal(?word,?tokens1,?tokens2) if 
	equals(?tokens1,<keyword(?word)|?tokens2>)