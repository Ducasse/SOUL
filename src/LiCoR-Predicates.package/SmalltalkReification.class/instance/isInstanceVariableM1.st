entities
isInstanceVariableM1

"+?InstVar isInstanceVariable verifies whether ?InstVar is an instance variable of some existing Smalltalk class
	 or returns the appropriate value if ?InstVar is variable.

CASE 1: +?InstVar isInstanceVariable checks whether ?InstVar is an existing instance variable"

+?InstVar isInstanceVariable if 
	[MLI forSmalltalk isInstanceVariable: ?InstVar].
"CASE 2: -?InstVar isInstanceVariable returns an existing instance variable"

-?InstVar isInstanceVariable if 
	[MLI forSmalltalk allInstanceVariableEntities] contains: ?InstVar