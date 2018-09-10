template parsing
stKeywordmessageWithReceiverM4

stKeywordmessageWithReceiver(?binaryMessage,?receiver,?tokens1,?tokens2) if 
	stBinarymessageWithReceiver(?binaryMessage,?receiver,?tokens1,?tokens2).

stKeywordmessageWithReceiver(RBMessageNode(?receiver,?selector,?arguments),?receiver,?tokens1,?tokens3) if 
	stKeywords(?keys,?tokens1,?tokens2),and({makeKeywordMessage(?keys,?selector,?arguments)},equals(?tokens2,?tokens3)).

stKeywordmessageWithReceiver(RBMessageNode(?receiver,?var,<?argumentexpression>),?receiver,?tokens1,?tokens3) if 
	soulvariable(?var,?tokens1,?tokens2),stBinarymessage(?argumentexpression,?tokens2,?tokens3)