binary relations
isClassInCategoryXM2

"Belongs ?Class to category ?Category"

?Class isClassInCategory: ?Category if 
	?Class isClass,?Category equals: [MLI forSmalltalk categoryForClass: ?Class]