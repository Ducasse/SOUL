template parsing
stLiteralM3

stLiteral(RBLiteralValueNode(true),?tokens1,?tokens2) if 
	equals(?tokens1,<word(true)|?tokens2>).
stLiteral(RBLiteralValueNode(false),?tokens1,?tokens2) if 
	equals(?tokens1,<word(false)|?tokens2>).
stLiteral(RBLiteralValueNode(nil),?tokens1,?tokens2) if 
	equals(?tokens1,<word(nil)|?tokens2>).
stLiteral(RBLiteralValueNode(?num),?tokens1,?tokens2) if 
	equals(?tokens1,<number(?num)|?tokens2>).
stLiteral(RBLiteralValueNode(?char),?tokens1,?tokens2) if 
	equals(?tokens1,<character(?char)|?tokens2>).
stLiteral(RBLiteralValueNode(?num),?tokens1,?tokens2) if 
	equals(?tokens1,<binary([#-]),number(?num)|?tokens2>).
stLiteral(RBLiteralValueNode(?string),?tokens1,?tokens2) if 
	equals(?tokens1,<string(?string)|?tokens2>)