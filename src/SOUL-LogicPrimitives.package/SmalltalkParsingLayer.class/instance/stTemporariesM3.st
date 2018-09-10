template parsing
stTemporariesM3

stTemporaries(?temporariesList,?tokens1,?tokens2) if 
	soulvariable(?temporariesList,?tokens1,?tokens2).
stTemporaries(?temporariesList,?tokens1,?tokens3) if 
	equals(?tokens1,<verticalBar(?)|?tokens2>),stTemporaries2(?temporariesList,?tokens2,?tokens3)