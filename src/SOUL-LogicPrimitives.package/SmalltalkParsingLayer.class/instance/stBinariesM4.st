template parsing
stBinariesM4

stBinaries(?exp,?result,?tokens1,?tokens3) if 
	stBinary(binary(?message,?arg),?tokens1,?tokens2),stBinaries(RBMessageNode(?exp,?message,<?arg>),?result,?tokens2,?tokens3).
stBinaries(?exp,RBMessageNode(?exp,?message,<?arg>),?tokens1,?tokens2) if 
	stBinary(binary(?message,?arg),?tokens1,?tokens2)