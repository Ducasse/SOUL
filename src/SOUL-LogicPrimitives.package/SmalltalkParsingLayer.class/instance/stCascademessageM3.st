template parsing
stCascademessageM3

stCascademessage(?keyWordMessage,?tokens1,?tokens2) if 
	stKeywordmessage(?keyWordMessage,?tokens1,?tokens2).

stCascademessage(RBCascadeNode(<?keyWordMessage|?cascadedMessages>),?tokens1,?tokens3) if 
	stKeywordmessage(?keyWordMessage,?tokens1,?tokens2),RBMessageNode(?receiver,?,?) equals: ?keyWordMessage,stCascadedMessages(?cascadedMessages,?receiver,?tokens2,?tokens3)