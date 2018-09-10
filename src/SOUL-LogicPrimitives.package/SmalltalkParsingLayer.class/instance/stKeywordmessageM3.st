template parsing
stKeywordmessageM3

stKeywordmessage(?binaryMessage,?tokens1,?tokens2) if 
	stBinarymessage(?binaryMessage,?tokens1,?tokens2).
stKeywordmessage(RBMessageNode(?binaryMessage,?selector,?arguments),?tokens1,?tokens4) if 
	stBinarymessage(?binaryMessage,?tokens1,?tokens2),stKeywords(?keys,?tokens2,?tokens3),and({makeKeywordMessage(?keys,?selector,?arguments)},equals(?tokens3,?tokens4)).
stKeywordmessage(RBMessageNode(?receiver,?var,<?argumentexpression>),?tokens1,?tokens4) if 
	stBinarymessage(?receiver,?tokens1,?tokens2),soulvariable(?var,?tokens2,?tokens3),stBinarymessage(?argumentexpression,?tokens3,?tokens4)