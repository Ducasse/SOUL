template parsing
stMethodM3

stMethod(RBMethodNode(?selector,?arguments,?body),?tokens1,?tokens3) if 
	stMethodHeader(methodHeader(?selector,?arguments),?tokens1,?tokens2),stMethodBody(?body,?tokens2,?tokens3)