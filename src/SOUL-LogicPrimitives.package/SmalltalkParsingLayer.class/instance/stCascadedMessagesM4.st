template parsing
stCascadedMessagesM4

stCascadedMessages(<?keyWordMessage>,?receiver,?tokens1,?tokens3) if 
	stsemicolon(?,?tokens1,?tokens2),stKeywordmessageWithReceiver(?keyWordMessage,?receiver,?tokens2,?tokens3),RBMessageNode(?,?,?) equals: ?keyWordMessage.

stCascadedMessages(<?keyWordMessage|?cascadedMessages>,?receiver,?tokens1,?tokens4) if 
	stsemicolon(?,?tokens1,?tokens2),soulvariable(?keyWordMessage,?tokens2,?tokens3),stCascadedMessages(?cascadedMessages,?receiver,?tokens3,?tokens4).

stCascadedMessages(<?keyWordMessage|?cascadedMessages>,?receiver,?tokens1,?tokens4) if 
	stsemicolon(?,?tokens1,?tokens2),stKeywordmessageWithReceiver(?keyWordMessage,?receiver,?tokens2,?tokens3),RBMessageNode(?,?,?) equals: ?keyWordMessage,stCascadedMessages(?cascadedMessages,?receiver,?tokens3,?tokens4).

stCascadedMessages(<?keyWordMessage,?cascadedMessages>,?receiver,?tokens1,?tokens4) if 
	stsemicolon(?,?tokens1,?tokens2),soulvariable(?keyWordMessage,?tokens2,?tokens3),stCascadedMessages(?cascadedMessages,?receiver,?tokens3,?tokens4),not(list(?cascadedMessages)).

stCascadedMessages(<?keyWordMessage,?cascadedMessages>,?receiver,?tokens1,?tokens4) if 
	stsemicolon(?,?tokens1,?tokens2),stKeywordmessageWithReceiver(?keyWordMessage,?receiver,?tokens2,?tokens3),RBMessageNode(?,?,?) equals: ?keyWordMessage,stCascadedMessages(?cascadedMessages,?receiver,?tokens3,?tokens4),not(list(?cascadedMessages)).

stCascadedMessages(?keyWordMessage,?receiver,?tokens1,?tokens3) if 
	stsemicolon(?,?tokens1,?tokens2),soulvariable(?keyWordMessage,?tokens2,?tokens3)