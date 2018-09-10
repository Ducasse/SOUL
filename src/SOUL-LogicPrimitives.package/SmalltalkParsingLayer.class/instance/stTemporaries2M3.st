template parsing
stTemporaries2M3

stTemporaries2(<?temp|?nextList>,?tokens1,?tokens3) if 
	stWordterminal(?temp,?tokens1,?tokens2),stTemporaries2(?nextList,?tokens2,?tokens3).
stTemporaries2(<>,?tokens1,?tokens2) if 
	equals(?tokens1,<verticalBar(?)|?tokens2>)