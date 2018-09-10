template parsing
stBinarymessageM3

stBinarymessage(?expression,?tokens1,?tokens2) if 
	stUnarymessage(?expression,?tokens1,?tokens2).
stBinarymessage(?result,?tokens1,?tokens3) if 
	stUnarymessage(?expression,?tokens1,?tokens2),stBinaries(?expression,?result,?tokens2,?tokens3)