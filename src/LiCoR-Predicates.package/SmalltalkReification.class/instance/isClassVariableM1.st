entities
isClassVariableM1

"+?ClassVar isClassVariableverifies whether ?ClassVar is a class variable of some existing class
	 or returns the appropriate value if ?ClassVar is variable.

CASE 1:+?ClassVar isClassVariable checks whether ?ClassVar is an existing class variable"

+?ClassVar isClassVariable if 
	[MLI forSmalltalk isClassVariable: ?ClassVar].
"CASE 2: -?ClassVar isClassVariable returns an existing class variable"

-?ClassVar isClassVariable if 
	[MLI forSmalltalk allClassVariableEntities] contains: ?ClassVar