binary relations
isMethodInClassXM2

"+?Method isMethodInClass: ?Class  verifies whether a ?Class contains
	 a given ?Method or returns the appropriate value if one (or more) of the arguments
	 is variable.

CASE 1: ?Method is known. Assumption: a method is in ONE class."

+?Method isMethodInClass: ?Class if 
	?Method isMethod,?Class equals: [MLI forSmalltalk classOfMethod: ?Method].
"CASE 2: ?Method is unknown"

-?Method isMethodInClass: ?Class if 
	?Class isClass,[MLI forSmalltalk methodsInClass: ?Class] contains: ?Method