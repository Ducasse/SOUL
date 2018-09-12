binary relations
isClassVariableInClassXM2

"?ClassVariable isClassVariableInClass: ?Class verifies whether a ?Class contains
	 a given ?ClassVariable or returns the appropriate values if one (or more) of the arguments
	 is variable.

CASE 1: +?ClassVariable isClassVariableInClass: ?Class"

+?ClassVariable isClassVariableInClass: ?Class if 
	?Class isClass,[MLI forSmalltalk isClassVariable: ?ClassVariable inClass: ?Class].
"CASE 2: -?ClassVariable isClassVariableInClass: ?Class"

-?ClassVariable isClassVariableInClass: ?Class if 
	?Class isClass,[MLI forSmalltalk allClassVariableEntitiesInClass: ?Class] contains: ?ClassVariable