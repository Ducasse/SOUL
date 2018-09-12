method body
isLastMessageInCascadeXM2

"Is ?Selector the last message that is sent in a ?Cascade?"

?Selector isLastMessageInCascade: RBCascadeNode(?MsgNodes) if 
	?LastMsgNode lastMemberOf: ?MsgNodes,RBMessageNode(?,?Selector,?) equals: ?LastMsgNode