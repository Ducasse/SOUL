template parsing
stWordterminalM3

stWordterminal(?word,?tokens1,?tokens2) if 
	equals(?tokens1,<word(?word)|?tokens2>).
stWordterminal(?var,?tokens1,?tokens2) if 
	soulvariable(?var,?tokens1,?tokens2)