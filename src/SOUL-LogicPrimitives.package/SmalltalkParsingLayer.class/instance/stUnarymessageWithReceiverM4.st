template parsing
stUnarymessageWithReceiverM4

stUnarymessageWithReceiver(?expression,?receiver,?tokens1,?tokens2) if 
	stBasicexpression(?expression,?tokens1,?tokens2).

stUnarymessageWithReceiver(?result,?receiver,?tokens1,?tokens2) if 
	stUnaries(?receiver,?result,?tokens1,?tokens2).

stUnarymessageWithReceiver(RBMessageNode(?receiver,?selector,?args),?receiver,?tokens1,?tokens2) if 
	stTemplateSelector(methodHeader(?selector,?args),?tokens1,?tokens2)