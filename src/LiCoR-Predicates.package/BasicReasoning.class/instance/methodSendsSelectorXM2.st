method body
methodSendsSelectorXM2

"Does the ?Method send selector ?Selector?"

?Method methodSendsSelector: ?Selector if 
	?Method isMethod,?tree isParseTreeOfMethod: ?Method,RBMessageNode(?,?Selector,?) isStChildOf: ?tree