template parsing
stBlockArgumentsM3

stBlockArguments(<?arg|?args>,?tokens1,?tokens4) if 
	equals(?tokens1,<colon(?)|?tokens2>),stVariable(?arg,?tokens2,?tokens3),stBlockArguments(?args,?tokens3,?tokens4).
stBlockArguments(<>,?tokens1,?tokens2) if 
	equals(?tokens1,<verticalBar(?)|?tokens2>)