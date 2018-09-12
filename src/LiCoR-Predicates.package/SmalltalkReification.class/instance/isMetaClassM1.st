entities
isMetaClassM1

"This predicate verifies whether ?Class is a meta class

CASE 1: the variable ?Class is bound"

+?Class isMetaClass if 
	[MLI forSmalltalk isMetaClass: ?Class].
"This predicate verifies whether ?Class is a meta class

CASE 2: the variable ?Class is not bound"

-?Class isMetaClass if 
	[MLI forSmalltalk allMetaClassEntities] contains: ?Class