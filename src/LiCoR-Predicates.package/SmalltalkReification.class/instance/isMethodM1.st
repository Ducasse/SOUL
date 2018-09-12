entities
isMethodM1

"+-?Method isMethod  verifies whether ?Method is a Smalltalk method. If ?Method is a variable
	 it will be instantiated with a method. If ?Method is bound it should be an
	 existing method in the current Smalltalk image.

CASE 1: +Method isMethod checks whether ?method is an existing method"

+?Method isMethod if 
	[MLI forSmalltalk isMethod: ?Method].
"CASE 2: -Method isMethod returns an existing method"

-?Method isMethod if 
	[MLI forSmalltalk allMethodEntities] contains: ?Method