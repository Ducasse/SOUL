parsetree traversal
isStChildOfXM2

?aTerm isStChildOf: ?aTerm if 
	not([?aTerm isKindOf: OrderedCollection]).
?aTerm isStChildOf: ?afunctor@(?args) if 
	?args contains: ?child,?aTerm isStChildOf: ?child