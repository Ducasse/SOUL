method body
methodReadsInstanceVariableXinClassXM3

"Does ?Method read instance variable ?Variable of class ?Class"

?Method methodReadsInstanceVariable: ?Variable inClass: ?class if 
	?Method isMethodWithName: ?Selector inClass: ?class,?Variable isInstanceVariableInClassChainOf: ?Class,[MLI forSmalltalk
	selectorsOfClass: ?Class
	whichRead: ?Variable asString] contains: ?Selector