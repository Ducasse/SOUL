template runtime
matchesArgumentsXM2

<> matchesArguments: <>.
<?blockArgMatch|?restMatchedArguments> matchesArguments: <?blockArg|?restArgs> if 
	?blockArgMatch equals: RBBlockNode(?t,RBSequenceNode(?,?statements)),?blockArg equals: RBBlockNode(?t,RBSequenceNode(?,?matchStatements)),?matchStatements matchesStatements: ?statements,?restMatchedArguments matchesArguments: ?restArgs.
<?argument|?restMatchedArguments> matchesArguments: <?argument|?restArgs> if 
	?restMatchedArguments matchesArguments: ?restArgs