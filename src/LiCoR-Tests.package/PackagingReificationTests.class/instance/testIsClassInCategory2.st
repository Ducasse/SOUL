binary relations
testIsClassInCategory2
	
	self processQuery:
			' if ?category isClassCategory,[?category = #''LiCoR-Tests''],?class isClassInCategory: ?category'
		description: 'We can extract classes from a category'.
	self processQuery:
			' if ?class isClass,[?class name asString = ''PackagingReificationTests''],?class isClassInCategory: ?category,[?category = #''LiCoR-Tests'']'
		description: 'We can extract the category from a class'