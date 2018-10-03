"
self suite run
"
Class {
	#name : #PackagingReificationTests,
	#superclass : #LiCoRTests,
	#category : 'LiCoR-Tests'
}

{ #category : #entities }
PackagingReificationTests >> testIsClassCategory1 [
	
	self processQuery: ' if succeeds(?Category isClassCategory)' description:
			'Can the predicate be used to extract categories?'.
	self processQuery: ' if succeeds([#''Kernel-Objects''] isClassCategory)'
		description: 'Is Kernel-Objects an existing class category?'
]

{ #category : #'binary relations' }
PackagingReificationTests >> testIsClassInCategory2 [
	
	self processQuery:
			' if ?category isClassCategory,[?category = #''LiCoR-Tests''],?class isClassInCategory: ?category'
		description: 'We can extract classes from a category'.
	self processQuery:
			' if ?class isClass,[?class name asString = ''PackagingReificationTests''],?class isClassInCategory: ?category,[?category = #''LiCoR-Tests'']'
		description: 'We can extract the category from a class'
]

{ #category : #'binary relations' }
PackagingReificationTests >> testIsClassInPackage2 [
	
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
]

{ #category : #entities }
PackagingReificationTests >> testIsPackage1 [
	
	self processQuery: ' if succeeds([Smalltalk organization categories first] isPackage)'
		description: 'Can we check for an existing package?'.
	self
		processQuery: ' if ?package isPackage'
		resultsCheck: [:results | results size = Smalltalk organization categories size]
		description: 'Can we enumerate all packages?'.
	self processQuery: ' if fails([''Soul''] isPackage)' description:
			'Does package fail for the string ''Soul''?'
]

{ #category : #entities }
PackagingReificationTests >> testIsProtocol1 [
	
	self processQuery: ' if succeeds(?Protocol isProtocol)' description:
			'Can the predicate be used to extract protocols?'.
	self processQuery: ' if succeeds([#accessing] isProtocol)' description:
			'Is accessing an existing method protocol?'
]

{ #category : #'binary relations' }
PackagingReificationTests >> testIsProtocolInClass2 [
	
	self processQuery:
			' if succeeds(and(?Protocol isProtocolInClass: ?Class,nonvar(?Protocol),nonvar(?Class)))'
		description:
			'Can the predicate isProtocolInClass:/2 be used to find all protocols of all classes?'.
	self processQuery:
			' if succeeds(and(?Protocol isProtocolInClass: ?Class,?Protocol isProtocol,?Class isClass))'
		description:
			'Is the result produced by the predicate isProtocolInClass:/2 of the expected type?'.
	self processQuery:
			' if succeeds([#protocol1] isProtocolInClass: [TestClass1])'
		description:
			'Can the predicate isProtocolInClass:/2 be used to check that a given protocol belongs to a given class?'.
	self processQuery: ' if succeeds([#protocol1] isProtocolInClass: ?Class)'
		description:
			'Can the predicate isProtocolInClass:/2 be used to find all classes with a given protocol?'.
	self
		processQuery: ' if ?protocol isProtocolInClass: [TestClass1]'
		resultsCheck: [:results | results size = 3]
		description: 'Can we ask for the protocols that are in a class?'.
	self processQuery: ' if fails(?protocol isProtocolInClass: foo)'
		description:
			'Does this predicate fail when given the wrong kind of parameters?'.
	self processQuery: ' if fails(theprotocolthatshouldnotexist isProtocolInClass: ?class)' description:
			'Does this predicate fail when given the wrong kind of parameters?'.
	self processQuery: ' if fails(foo isProtocolInClass: foo)' description:
			'Does this predicate fail when given the wrong kind of parameters?'
]
