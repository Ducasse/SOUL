template runtime
isMessageSendInXwithRestXM3

RBMessageNode(?receiver,?selector,?arguments) isMessageSendIn: <RBMessageNode(?receiver,?selector,?matchedArguments)|?next> withRest: ?next if 
	?matchedArguments contains: RBBlockNode(?,?),?matchedArguments matchesArguments: ?arguments.
RBMessageNode(?receiver,?selector,?arguments) isMessageSendIn: <RBMessageNode(?receiver,?selector,?arguments)|?next> withRest: ?next if 
	not(?arguments contains: RBBlockNode(?,?)).
?statement isMessageSendIn: <RBReturnNode(?statement)|?next> withRest: ?next.
?statement isMessageSendIn: <?first|?next> withRest: ?nextStatements if 
	?statement isMessageSendIn: ?next withRest: ?nextStatements