entities
isBaseClassM1

"This predicate verifies whether ?Class is a base class

CASE 1: the variable ?Class is bound"

+?class isBaseClass if 
	[MLI forSmalltalk isBaseClass: ?class].
"This predicate verifies whether ?Class is a base class 

CASE 2: the variable ?Class is not bound"

-?Class isBaseClass if 
	[MLI forSmalltalk allBaseClassEntities] contains: ?Class