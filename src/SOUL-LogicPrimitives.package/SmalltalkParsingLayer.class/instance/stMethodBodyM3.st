template parsing
stMethodBodyM3

stMethodBody(RBSequenceNode(?temporaries,?statements),?tokens1,?tokens3) if 
	stTemporaries(?temporaries,?tokens1,?tokens2),stStatementList(?statements,?tokens2,?tokens3).
stMethodBody(RBSequenceNode(<>,?statements),?tokens1,?tokens2) if 
	stStatementList(?statements,?tokens1,?tokens2)