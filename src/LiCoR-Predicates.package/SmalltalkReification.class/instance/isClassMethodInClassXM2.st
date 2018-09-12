binary relations
isClassMethodInClassXM2

"?Method isClassMethodInClass: ?Class verifies whether a ?Class contains
	 a given class ?Method or returns the appropriate value if one (or more) of the arguments
	 is variable.

CASE 1: ?Method is known"

+?Method isClassMethodInClass: ?Class if 
	?Class isClass,[MLI forSmalltalk isClassMethod: ?Method inClass: ?Class].
"CASE 2: ?Method is unknown"

-?Method isClassMethodInClass: ?Class if 
	?Class isClass,[MLI forSmalltalk classMethodsInClass: ?Class] contains: ?Method