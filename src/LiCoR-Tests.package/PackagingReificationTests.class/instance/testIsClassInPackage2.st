binary relations
testIsClassInPackage2
	
	self
		processQuery:
			' if ?class isClassInPackage: [''LiCoR-Tests'']'
		resultsCheck:
			[:results | 
			(Smalltalk allClasses select:[:each | each category = 'LiCoR-Tests']) size = results size]
		description: 'Can we get all the classes defined in a given package?'.	"First we get a random package (for example the first one we encounter). Then we take a random Smalltalk class
	 that does NOT belong to this package and we check that classInPackage/2 indeed fails."

	self processQuery:
			' if succeeds([PackagingReificationTests] isClassInPackage: [''LiCoR-Tests''])'
		description: 'Can we test the package for a class?'.
	self processQuery:
			' if succeeds(and([PackagingReificationTests] isClassInPackage: ?P,[?P = ''LiCoR-Tests'']))'
		description: 'Can we get the package for a class?'.
	self processQuery:
			' if succeeds(and([PackagingReificationTests class] isClassInPackage: ?P,[?P = ''LiCoR-Tests'']))'
		description:
			'Can we get the package for a metaclass using classInPackage/2?'.
	self processQuery:
			' if succeeds(and(?P isPackage,[?P = ''LiCoR-Tests''],[PackagingReificationTests class] isClassInPackage: ?P))'
		description:
			'Can we get the package for a metaclass using isClassInPackage:/2?'.
	self
		processQuery: ' if [Object] isClassInPackage: ?P'
		resultsCheck: [:results | results size = 1]
		description:
			'Does the isClassInPackage:/2 predicate only returns the package where the class is defined (and not where it is extended)?)'.
	self processQuery: ' if fails([1] isClassInPackage: [#succeeds])'
		description:
			'Does the predicate fail when not passed classes or packages'