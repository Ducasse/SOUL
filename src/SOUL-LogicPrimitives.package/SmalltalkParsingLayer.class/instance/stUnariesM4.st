template parsing
stUnariesM4

stUnaries(?exp,?result,?tokens1,?tokens3) if 
	stWordterminal(?message,?tokens1,?tokens2),stUnaries(RBMessageNode(?exp,?message,<>),?result,?tokens2,?tokens3).
stUnaries(?exp,RBMessageNode(?exp,?message,<>),?tokens1,?tokens2) if 
	stWordterminal(?message,?tokens1,?tokens2)