binary relations
isInstanceVariableInClassXM2

"+?InstanceVariable isInstanceVariableInClass: ?Class verifies whether a ?Class contains
	 a given ?InstanceVariable or returns the appropriate values if one (or more) of the arguments
	 is variable.

CASE 1: +?InstanceVariable isInstanceVariableInClass: +-?Class"

+?InstanceVariable isInstanceVariableInClass: ?Class if 
	?Class isClass,[MLI forSmalltalk isInstanceVariable: ?InstanceVariable inClass: ?Class].
"CASE 2: -?InstanceVariable isInstanceVariableInClass: +-?Class"

-?InstanceVariable isInstanceVariableInClass: ?Class if 
	?Class isClass,[MLI forSmalltalk allInstanceVariableEntitiesInClass: ?Class] contains: ?InstanceVariable