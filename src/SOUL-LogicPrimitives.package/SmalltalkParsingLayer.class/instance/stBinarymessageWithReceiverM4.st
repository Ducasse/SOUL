template parsing
stBinarymessageWithReceiverM4

stBinarymessageWithReceiver(?expression,?receiver,?tokens1,?tokens2) if 
	stUnarymessageWithReceiver(?expression,?receiver,?tokens1,?tokens2).

stBinarymessageWithReceiver(?result,?receiver,?tokens1,?tokens2) if 
	stBinaries(?receiver,?result,?tokens1,?tokens2)