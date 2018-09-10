template parsing
stBlockM3

stBlock(RBBlockNode(?args,?body),?tokens1,?tokens5) if 
	equals(?tokens1,<leftBracket(?)|?tokens2>),stBlockArguments(?args,?tokens2,?tokens3),stMethodBody(?body,?tokens3,?tokens4),equals(?tokens4,<rightBracket(?)|?tokens5>).

stBlock(RBBlockNode(<>,?body),?tokens1,?tokens4) if 
	equals(?tokens1,<leftBracket(?)|?tokens2>),stMethodBody(?body,?tokens2,?tokens3),equals(?tokens3,<rightBracket(?)|?tokens4>)