template parsing
stBinaryM3

stBinary(binary(?binary,?expression),?tokens1,?tokens3) if 
	stBinaryterminal(?binary,?tokens1,?tokens2),stUnarymessage(?expression,?tokens2,?tokens3).
stBinary(binary([#-],?num),?tokens1,?tokens2) if 
	equals(?tokens1,<binary([#-]),number(?num)|?tokens2>)