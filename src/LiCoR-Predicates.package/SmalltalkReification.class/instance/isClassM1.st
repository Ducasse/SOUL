entities
isClassM1

"This predicate verifies whether ?Class is a base or meta class

CASE 1: the variable ?Class is bound"

+?Class isClass if 
	[MLI forSmalltalk isClass: ?Class].
"This predicate verifies whether ?Class is a base or meta class

CASE 2: the variable ?Class is not bound"

-?Class isClass if 
	[MLI forSmalltalk allClassEntities] contains: ?Class