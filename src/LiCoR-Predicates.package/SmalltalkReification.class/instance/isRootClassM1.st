entities
isRootClassM1

"isRootClass verifies whether ?Class is a root class, i.e., whether it has
	 no superclass. If ?Class is variable it will be instantiated with such a class.
	 If ?Class is bound it should be an existing root class in the current system.

CASE 1: rootClass(+?Class) checks whether ?Class is an existing root class"

+?Class isRootClass if 
	[MLI forSmalltalk isRootClass: ?Class].
"CASE 2: isRootClass returns an existing root class"

-?Class isRootClass if 
	[MLI forSmalltalk allRootClassEntities] contains: ?Class