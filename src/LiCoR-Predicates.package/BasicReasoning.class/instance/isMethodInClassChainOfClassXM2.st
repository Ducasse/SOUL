methods
isMethodInClassChainOfClassXM2

"Returns all methods ?Method implemented in the class chain of ?Class (either by ?Class itself or by any of its superclasses)

Case 1: ?Class implements ?Method itself"

?Method isMethodInClassChainOfClass: ?Class if 
	?Method isMethodInClass: ?Class.
"Returns all methods ?Method implemented in the class chain of ?Class (either by ?Class itself or by any of its superclasses)

Case 2: A superclass of ?Class implements ?Method"

?Method isMethodInClassChainOfClass: ?Class if 
	?Superclass isClassAbove: ?Class,?Method isMethodInClass: ?Superclass