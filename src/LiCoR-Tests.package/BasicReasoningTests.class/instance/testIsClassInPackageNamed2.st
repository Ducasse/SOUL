naming
testIsClassInPackageNamed2
	
	self
		processQuery: ' if ?class isClassInPackageNamed: [''LiCoR-Tests'']'
		resultsCheck:
			[:results | 
			results size = (Smalltalk allClasses select:[:cl | cl category = 'LiCoR-Tests']) size]
		description:
			'Can we get all the classes defined in a package with a given name?'.
	self processQuery:
			' if [PackagingReificationTests] isClassInPackageNamed: {LiCoR-Tests}'
		description: 'Can we test check the name of the package for a class?'.
	self processQuery:
			' if succeeds(and([PackagingReificationTests] isClassInPackageNamed: ?N,?P isPackageWithName: ?N))'
		description: 'Can we get the package for a class?'.
	self processQuery:
			' if succeeds(and([PackagingReificationTests class] isClassInPackageNamed: ?N,?P isPackageWithName: ?N))'
		description: 'Can we get the package for a  metaclass?'.
	self
		processQuery: ' if [Object] isClassInPackageNamed: ?N'
		resultsCheck: [:results | results size = 1]
		description:
			'Does the predicate only returns the package where the class is defined (and not where it is extended)?)'.
	self processQuery: ' if fails([1] isClassInPackageNamed: ?N)' description:
			'Does the predicate fail when not passed a class as first argument'.
	self processQuery: ' if fails(?C isClassInPackageNamed: [1])' description:
			'Does the predicate fail when not passed a string as second argument'