"
self suite run


"
Class {
	#name : #BasicReasoningTests,
	#superclass : #LiCoRTests,
	#category : 'LiCoR-Tests'
}

{ #category : #private }
BasicReasoningTests class >> methodForCode: aString [
	"Take aString, and return a method for that string. This is used for tests that need to generate methods on the fly. Otherwise those methods have to be stored on test classes all the time, which is not always desired."

	
	^Compiler new
		compile: aString
		in: nil
		allowReceiver: true
		class: nil class
		environment: Smalltalk
		noPattern: false
		notifying: nil
		ifFail: [^nil]
]

{ #category : #private }
BasicReasoningTests >> addTestPackage1 [
	
	| testPackage previousPackage |
	previousPackage := Registry currentPackage.
	testPackage := PackageModel named: 'TestPackage1'.
	Registry currentPackage: testPackage.
	Soul defineClass: #PackageTestClass1 superclass: Object indexedType: #none
		private: false instanceVariableNames: '' classInstanceVariableNames: ''
		imports: '' category: 'Soul-LogicTestClasses'.
	Registry currentPackage: previousPackage
]

{ #category : #private }
BasicReasoningTests >> addTestPackage2 [
	
	| testPackage previousPackage |
	previousPackage := Registry currentPackage.
	testPackage := PackageModel named: 'TestPackage2'.
	Registry currentPackage: testPackage.
	Soul defineClass: #PackageTestClass2 superclass: PackageTestClass1
		indexedType: #none private: false instanceVariableNames: ''
		classInstanceVariableNames: '' imports: '' category:
			'Soul-LogicTestClasses'.
	Registry currentPackage: previousPackage
]

{ #category : #private }
BasicReasoningTests >> addTestPackage3 [
	
	| testPackage previousPackage |
	previousPackage := Registry currentPackage.
	testPackage := PackageModel named: 'TestPackage3'.
	Registry currentPackage: testPackage.
	Soul defineClass: #PackageTestClass3 superclass: PackageTestClass2
		indexedType: #none private: false instanceVariableNames: ''
		classInstanceVariableNames: '' imports: '' category:
			'Soul-LogicTestClasses'.
	Registry currentPackage: previousPackage
]

{ #category : #private }
BasicReasoningTests >> addTestPackages1And2 [
	
	self removeTestPackages1And2.
	self addTestPackage1.
	self addTestPackage2
]

{ #category : #private }
BasicReasoningTests >> addTestPackages1And2And3 [
	
	self removeTestPackages1And2And3.
	self addTestPackage1.
	self addTestPackage2.
	self addTestPackage3
]

{ #category : #private }
BasicReasoningTests >> removeTestPackage1 [
	
	PackageTestClass1 ifDefinedDo: [:cl | cl removeFromSystem].
	Registry removePackage: (Registry packageNamed: 'TestPackage1')
]

{ #category : #private }
BasicReasoningTests >> removeTestPackage2 [
	
	PackageTestClass2 ifDefinedDo: [:cl | cl removeFromSystem].
	Registry removePackage: (Registry packageNamed: 'TestPackage2')
]

{ #category : #private }
BasicReasoningTests >> removeTestPackage3 [
	
	PackageTestClass3 ifDefinedDo: [:cl | cl removeFromSystem].
	Registry removePackage: (Registry packageNamed: 'TestPackage3')
]

{ #category : #private }
BasicReasoningTests >> removeTestPackages1And2 [
	
	self removeTestPackage2.
	self removeTestPackage1
]

{ #category : #private }
BasicReasoningTests >> removeTestPackages1And2And3 [
	
	self removeTestPackage3.
	self removeTestPackage2.
	self removeTestPackage1
]

{ #category : #methods }
BasicReasoningTests >> testAreArgumentsOfMethod2 [
	
	self processQuery:
			' if succeeds(and(?method isMethodWithName: array inClass: [TestClass1],<> areArgumentsOfMethod: ?method))'
		description: 'checks whether Soul.TestClass1>>array has no arguments'.
	self processQuery:
			' if succeeds(and(?method isMethodWithName: [#array:] inClass: [TestClass1],<RBVariableNode(anArray)> areArgumentsOfMethod: ?method))'
		description:
			'checks whether Soul.TestClass1>>array: has a single argument called anArray'.
	self processQuery:
			' if succeeds(and(?method isMethodWithName: [#complexWith:and:and:and:] inClass: [TestClassRoot],<RBVariableNode(modifiers),RBVariableNode(bindings),RBVariableNode(specificImports),RBVariableNode(generalImports)> areArgumentsOfMethod: ?method))'
		description:
			'checks whether Soul.TestClassRoot>>complexWith:and:and:and: has a four arguments'
]

{ #category : #'method body' }
BasicReasoningTests >> testAreStatementsOfMethod2 [
	
	self processQuery:
			' if succeeds(and(?Method isMethodWithName: methodWithSend inClass: [TestClassRoot],<?statement> areStatementsOfMethod: ?Method))'
		description: 'This method has a single statement.'.
	self processQuery:
			' if succeeds(and(?Method isMethodWithName: foo inClass: [TestClassRoot],?statements areStatementsOfMethod: ?Method,length(?statements,2)))'
		description: 'This method has two statements.'.
	self processQuery:
			' if succeeds(and(?Method isMethodWithName: foo inClass: [SubClass1],<> areStatementsOfMethod: ?Method))'
		description: 'This method has no statements.'
]

{ #category : #classes }
BasicReasoningTests >> testClassCallsMethod2 [
	
	self processQuery:
			' if succeeds(and(?M isMethodWithName: methodWithAssignment inClass: [TestClassRoot],[TestClassRoot] classCallsMethod: ?M))'
		description:
			'Verify that this class calls a method named methodWithAssignment'
]

{ #category : #classes }
BasicReasoningTests >> testClassImplementsSelector2 [
	
	self processQuery: ' if [TestClass1] classImplementsSelector: array'
		description:
			'Tests whether classImplements correctly determines that TestClass1 implements a method named #array'.
	self processQuery:
			' if ?c classImplementsSelector: array,?c equals: [TestClass1]'
		description:
			'Tests whether TestClass1 is one of the solutions when checking for implementers of #array'.
	self processQuery:
			' if [TestClass1] classImplementsSelector: ?s,?s equals: array'
		description:
			'Tests whether #array is one of the solutions when checking for the selectors implemented by TestClass1'.
	self processQuery:
			' if not([TestClass1] classImplementsSelector: veryUnlikelyNameForAMethod)'
		description:
			'Tests whether classImplements correctly determines that TestClass1 does not implement a certain method'.
	self processQuery:
			' if [Object] classImplementsSelector: shouldNotImplement' description:
			'Tests whether classImplements correctly determines that Object implements a method named #shouldNotImplement'.
	self processQuery:
			' if not(?c classImplementsSelector: shouldNotImplement,not(?c equals: [Object]))'
		description:
			'Tests that the Object class is the only result returned when searching for classes that implement #shouldNotImplement'.
	self processQuery:
			' if not([TestClass1] classImplementsSelector: ?selector,not([TestClass1] classImplementsSelector: ?selector))'
		description:
			'Sanity test for optimized implementations of classImplements that have seperate cases depending on whether ?selector is bound or not: solutions generated by leaving ?selector unbound should make the predicate hold as well in the bound case'.
	self processQuery:
			' if not(?class classImplementsSelector: #at:put:,not(?class classImplementsSelector: #at:put:))'
		description:
			'Sanity test for optimized implementations of classImplements that have seperate cases depending on whether ?class is bound or not: solutions generated by leaving ?class unbound should make the predicate hold as well in the bound case'.
	self processQuery: ' if one(?class classImplementsSelector: ?selector)'
		description:
			'Sanity test for optimized implementations of classImplements that have seperate cases for the different bound status of its variables: leaving both variables unbound should at least generate one solution and not simply fail'
]

{ #category : #classes }
BasicReasoningTests >> testClassInheritsFrom2 [
	
	self
		processQuery: ' if ?SubClass classInheritsFrom: [TestClass1]'
		resultsCheck: [:results | results size = 2]
		description: 'Are there two classes in the hierarchy of TestClass1'.
	self processQuery:
			' if fails([TestClass1] classInheritsFrom: [TestClass1])' description:
			'Does TestClass1 belong to its own hierarchy?'.
	self processQuery:
			' if succeeds([SubClass1] classInheritsFrom: [TestClass1])' description:
			'Does SubClass1 belong to the hierarchy of TestClass1?'.
	self processQuery:
			' if succeeds([SubClass2] classInheritsFrom: [TestClass1])' description:
			'Does SubClass2 belong to the hierarchy of TestClass1?'.
	self
		processQuery: ' if ?SubClass classInheritsFrom: [TestClass2]'
		resultsCheck: [:results | results size = 0]
		description: 'There is no class inheriting from TestClass2'.
	self processQuery:
			' if fails([TestClass2] classInheritsFrom: [TestClass2])' description:
			'Does TestClass2 belong to its own hierarchy?'.
	self
		processQuery: ' if [SubClass1] classInheritsFrom: ?Root'
		resultsCheck: [:results | results size >= 2]
		description:
			'Are there at least two classes above SubClass1 (including SubClass1 itself)?'.
	self processQuery: ' if succeeds(one(?SubClass classInheritsFrom: ?Root))'
		description: 'Does classInheritsFrom:/2 work with two unbound arguments?'
]

{ #category : #classes }
BasicReasoningTests >> testClassUnderstandsSelector2 [
	
	self processQuery:
			' if succeeds([Object] classUnderstandsSelector: [#at:put:])'
		description: 'Does object understand #at:put: ?'.
	self processQuery:
			' if succeeds(?class classUnderstandsSelector: [#at:put:])' description:
			'Can we collect all classes understanding #at:put: ?'.
	self processQuery:
			' if succeeds(and(?class classUnderstandsSelector: [#at:put:],?class equals: [OrderedCollection]))'
		description:
			'Is OrderedCollection one of the classes understanding #at:put: ?'.
	self processQuery:
			' if succeeds([TestClass1] classUnderstandsSelector: array)'
		description: 'Direct implementation'.
	self processQuery:
			' if succeeds([SubClass1] classUnderstandsSelector: array)' description:
			'Indirect implementation'
]

{ #category : #classes }
BasicReasoningTests >> testIsAbstractClass [
	
	self processQuery: ' if succeeds([TestClassRoot] isAbstractClass)'
		description:
			'This class is abstract because it implements an abstract method'.
	self processQuery: ' if succeeds([SubClass3] isAbstractClass)'
		description:
			'This class is abstract because it parent has an abstract method'.
	self processQuery: ' if fails([ConcreteSubClass] isAbstractClass)'
		description:
			'This class provides an implementation for all abstract methods'.
	self processQuery: ' if succeeds([AbstractSubclass] isAbstractClass)'
		description:
			'This class provides an implementation for all but one of its parents abstract methods'
]

{ #category : #methods }
BasicReasoningTests >> testIsAbstractMethod1 [
	
	self processQuery:
			' if succeeds(and(?method isMethodWithName: anAbstractMethod inClass: [TestClass3],?method isAbstractMethod))'
		description:
			'checks whether Soul.TestClass3>>anAbstractMethod is an abstract method'.
	self processQuery:
			' if succeeds(and(?method isMethodWithName: anotherAbstractMethod inClass: [TestClass3],?method isAbstractMethod))'
		description:
			'checks whether Soul.TestClass3>>anotherAbstractMethod is an abstract method'.
	self processQuery:
			' if fails(and(?method isMethodWithName: aMethod1 inClass: [TestClass3],?method isAbstractMethod))'
		description:
			'checks whether Soul.TestClass3>>aMethod1 is an abstract method'
]

{ #category : #methods }
BasicReasoningTests >> testIsCancelledMethod1 [
	
	self processQuery:
			' if succeeds(and(?method isMethodWithName: anUnimplementedMethod inClass: [TestClass3],?method isCancelledMethod))'
		description:
			'checks whether Soul.TestClass3>>anUnimplementedMethod is an abstract method'.
	self processQuery:
			' if succeeds(and(?method isMethodWithName: ? inClass: [TestClass3],?method isCancelledMethod))'
		description: 'Can we find cancelled methods in class TestClass3?'
]

{ #category : #classes }
BasicReasoningTests >> testIsClassAbove2 [
	
	self processQuery: ' if fails([TestClass1] isClassAbove: [TestClass1])'
		description: 'A class not be above itself.'.
	self processQuery: ' if fails([SubClass1] isClassAbove: [TestClass1])'
		description: 'Is SubClass1 not in the hierarchy above TestClass1?'.
	self processQuery: ' if [TestClass1] isClassAbove: [SubClass1]'
		description: 'Is TestClass1 in the hierarchy above SubClass1?'.
	self processQuery:
			' if fails(and(?root isRootClass,?SuperClass isClassAbove: ?root))'
		description: 'There are no classes above a root class.'.
	self processQuery: ' if succeeds(?SuperClass isClassAbove: ?Class)'
		description: 'Does isClassAbove:/2 work with two unbound arguments?'
]

{ #category : #classes }
BasicReasoningTests >> testIsClassBelow2 [
	
	self
		processQuery: ' if ?SubClass isClassBelow: [TestClass1]'
		resultsCheck: [:results | results size = 2]
		description:
			'Are there three classes in the hierarchy BELOW TestClass1 (i.e. all descendants of TestClass1 excluding itself.'.
	self
		processQuery: ' if ?SubClass isClassBelow: [TestClass3]'
		resultsCheck: [:results | results size = 3]
		description: 'Are there three classes in the hierarchy BELOW TestClass3'.
	self processQuery: ' if fails([TestClass1] isClassBelow: [TestClass1])'
		description: 'A class not be below itself.'.
	self processQuery: ' if succeeds([SubClass1] isClassBelow: [TestClass1])'
		description: 'Is SubClass1 in the hierarchy below TestClass1?'.
	self processQuery: ' if succeeds([SubClass2] isClassBelow: [TestClass1])'
		description: 'Is SubClass2 in the hierarchy below TestClass1?'.
	self processQuery: ' if fails(?SubClass isClassBelow: [TestClass2])'
		description: 'There no classes in the hierarchy BELOW TestClass2.'.
	self
		processQuery: ' if [SubClass1] isClassBelow: ?Root'
		resultsCheck: [:results | results size >= 3]
		description:
			'Are there at least three classes ABOVE SubClass1 (excluding SubClass1 itself)?'.
	self processQuery: ' if succeeds(?SubClass isClassBelow: ?Root)'
		description: 'Does classBelow/2 work with two unbound arguments?'.
	
]

{ #category : #classes }
BasicReasoningTests >> testIsClassInHierarchyOf2 [
	
	self
		processQuery: ' if ?SubClass isClassInHierarchyOf: [TestClass1]'
		resultsCheck: [:results | results size = 3]
		description:
			'Are there three classes in the hierarchy of TestClass1 (i.e. TestClass1 itself and two subclasses?'.
	self processQuery:
			' if succeeds([TestClass1] isClassInHierarchyOf: [TestClass1])'
		description: 'Does TestClass1 belong to its own hierarchy?'.
	self processQuery:
			' if succeeds([SubClass1] isClassInHierarchyOf: [TestClass1])'
		description: 'Does SubClass1 belong to the hierarchy of TestClass1?'.
	self processQuery:
			' if succeeds([SubClass2] isClassInHierarchyOf: [TestClass1])'
		description: 'Does SubClass2 belong to the hierarchy of TestClass1?'.
	self
		processQuery: ' if ?SubClass isClassInHierarchyOf: [TestClass2]'
		resultsCheck: [:results | results size = 1]
		description:
			'Is there one class in the hierarchy of TestClass2 (i.e. only TestClass2 itself)'.
	self processQuery:
			' if succeeds([TestClass2] isClassInHierarchyOf: [TestClass2])'
		description: 'Does TestClass2 belong to its own hierarchy?'.
	self processQuery:
			' if fails(and(?SubClass isClassInHierarchyOf: [TestClass2],not(?SubClass equals: [TestClass2])))'
		description: 'Does TestClass2 only contain itself in its hierarchy?'.
	self
		processQuery: ' if [SubClass1] isClassInHierarchyOf: ?Root'
		resultsCheck: [:results | results size >= 3]
		description:
			'Are there at least three classes above SubClass1 (including SubClass1 itself)?'.
	self processQuery:
			' if succeeds(one(?SubClass isClassInHierarchyOf: ?Root))' description:
			'Does isClassInHierarchyOf:/2 work with two unbound arguments?'
]

{ #category : #naming }
BasicReasoningTests >> testIsClassInPackageNamed2 [
	
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
]

{ #category : #methods }
BasicReasoningTests >> testIsClassMethod1 [
	
	self processQuery:
			' if succeeds(and(?method isMethodWithName: aClassMethod inClass: [TestClassRoot class],?method isClassMethod))'
		description:
			'checks whether Soul.TestClassRoot class>>aClassMethod is a class method'.
	self processQuery:
			' if fails(and(?method isMethodWithName: aMethod1 inClass: [TestClass3],?method isClassMethod))'
		description: 'checks whether Soul.TestClass3>>aMethod1 is a class method'
]

{ #category : #naming }
BasicReasoningTests >> testIsClassWithName2 [
	"self run: #testclassWithName2"

	
	self processQuery:
			' if succeeds(and(?Class isClassWithName: [#Object],nonvar(?Class)))'
		description: 'Can we find a class with a given name?'.
	self processQuery:
			' if succeeds(and(?Class isClassWithName: Object,nonvar(?Class)))'
		description:
			'Can we find a class with a given name? (here we use the shortcut notation for symbols)'.
	self processQuery:
			' if succeeds(and([Object] isClassWithName: ?ClassName,nonvar(?ClassName)))'
		description: 'Can we retrieve the name of a given class?'.
	self processQuery: ' if succeeds([Object] isClassWithName: [#Object])'
		description: 'Can we verify whether a class has a given name?'.
	self processQuery: ' if succeeds([Object] isClassWithName: Object)'
		description:
			'Can we verify whether a class has a given name?  (here we use the shortcut notation for symbols)'.
	self processQuery:
			' if succeeds(one(and(?Class isClassWithName: ?ClassName,nonvar(?Class),nonvar(?ClassName))))'
		description: 'Can we retrieve a class and its name?'.
	self processQuery:
			' if succeeds(and(?Class isClassWithName: [#Object],nonvar(?Class),?Class equals: [Object]))'
		description:
			'Can we find a class with a given name and is it the correct class?'.
	self processQuery:
			' if succeeds(and([Object] isClassWithName: ?ClassName,nonvar(?ClassName),?ClassName equals: [#Object]))'
		description:
			'Can we find the name of a given class and is it the correct name?'.
	self processQuery:
			' if succeeds(and(?Class isClassWithName: [#''Object class''],nonvar(?Class)))'
		description: 'Can we find a meta class with a given name?'.
	self processQuery:
			' if succeeds(and([Object class] isClassWithName: ?ClassName,nonvar(?ClassName)))'
		description: 'Can we find the name of a given meta class?'.
	self processQuery:
			' if succeeds([Object class] isClassWithName: [#''Object class''])'
		description: 'Can we verify whether a meta class has a given name?'
]

{ #category : #'method body' }
BasicReasoningTests >> testIsLastMessageInCascade2 [
	
	self processQuery:
			' if succeeds(and(?Method isMethodWithName: foo inClass: [TestClassRoot],?tree isParseTreeOfMethod: ?Method,?cascade isStChildOf: ?tree,zork isLastMessageInCascade: ?cascade))'
		description: 'This method a single cascade that finishes with zork'.
	self processQuery:
			' if fails(and(?Method isMethodWithName: foo inClass: [TestClassRoot],?tree isParseTreeOfMethod: ?Method,?cascade isStChildOf: ?tree,[#compile:] isLastMessageInCascade: ?cascade))'
		description: 'This method a single cascade that finishes with zork'
]

{ #category : #methods }
BasicReasoningTests >> testIsMethodInClassChainOfClass2 [
	
	self processQuery:
			' if succeeds(and(?Method isMethodInClassChainOfClass: [TestClass1],?Method isMethodWithName: array))'
		description: 'The class implements the method directly'.
	self processQuery:
			' if succeeds(and(?Method isMethodInClassChainOfClass: [TestClass1],?Method isMethodWithName: foo))'
		description: 'The class implements the method indirectly'.
	self processQuery:
			' if fails(and(?Method isMethodInClassChainOfClass: [TestClass1],?Method isMethodWithName: DOESNOTEXIST))'
		description: 'Method that does not exist'
]

{ #category : #methods }
BasicReasoningTests >> testIsMethodInProtocol [
	
	self processQuery:
			' if succeeds(and(?Method isMethodInClass: [TestClass1],?Method isMethodInProtocol: ?Protocol))'
		description:
			'Can the predicate isMethodInProtocol:/2 be used with the second argument variable?'.
	self processQuery:
			' if succeeds(and(?Method isMethodInClass: [TestClass1],?Method isMethodInProtocol: ?Protocol,?Protocol equals: [#protocol1]))'
		description:
			'Can the predicate isMethodInProtocol:/2 be used with the second argument variable?'.
	self processQuery:
			' if succeeds(and(?Method isMethodInClass: [TestClass1],?Method isMethodInProtocol: protocol1))'
		description:
			'Can the predicate isMethodInProtocol:/2 be used with the second argument bound?'
]

{ #category : #methods }
BasicReasoningTests >> testIsMethodOfClassInProtocol [
	
	self processQuery:
			' if succeeds(?Method isMethodInClass: [TestClass1] inProtocol: ?Protocol)'
		description:
			'Can the predicate isMethodInClass:inProtocol:/3 be used to find all methods and protocols in a given class?'.
	self processQuery:
			' if succeeds(and(?Method isMethodInClass: [TestClass1],?Method isMethodInClass: ?Class inProtocol: ?Protocol))'
		description:
			'Can the predicate isMethodInClass:inProtocol:/3 be used to find the class and protocol of a given method?'.
	self processQuery:
			' if succeeds(and(?Method isMethodInClass: [TestClass1],?Method isMethodInClass: ?Class inProtocol: ?Protocol,?Protocol equals: [#protocol1]))'
		description:
			'Can the predicate isMethodInClass:inProtocol:/3 be used to find the class and protocol of a given method?'.
	self processQuery:
			' if succeeds(and(?Method isMethodInClass: [TestClass1],?Method isMethodInClass: ?Class inProtocol: protocol1))'
		description:
			'Can the predicate isMethodInClass:inProtocol:/3 be used to find the class and protocol of a given method?'
]

{ #category : #naming }
BasicReasoningTests >> testIsMethodWithName2 [
	"self run: #testmethodWithName2"

	
	self processQuery:
			' if succeeds(and(?method isMethodInClass: [TestClass3],?method isMethodWithName: [#anAbstractMethod]))'
		description:
			'The name of TestClass3>>#anAbstractMethod is #anAbstractMethod.'
]

{ #category : #naming }
BasicReasoningTests >> testIsMethodWithNameInClass3 [
	
	self
		processQuery:
			' if ?Method isMethodWithName: ?Selector inClass: [TestClass1]'
		resultsCheck: [:results | results size = 9]
		description:
			'Can the predicate be used with the first two arguments variable?'.
	self
		processQuery:
			' if ?Method isMethodWithName: [#method1] inClass: [TestClass1]'
		resultsCheck: [:results | results size = 1]
		description:
			'Can we use the predicate to find a method with a given name in a given class?'.
	self
		processQuery:
			' if ?Method isMethodInClass: [TestClass1],?Method isMethodWithName: ?Selector inClass: ?Class,?Class equals: [TestClass1],nonvar(?Selector)'
		resultsCheck: [:results | results size = 9]
		description:
			'Can we use the predicate to find the class and name of a given method?'
]

{ #category : #methods }
BasicReasoningTests >> testIsOverriddenSelectorinClass2 [
	
	self processQuery:
			' if succeeds(foo isOverriddenSelectorInClass: [TestClass4])'
		description: 'foo is overridden'.
	self processQuery:
			' if fails(foo isOverriddenSelectorInClass: [TestClassRoot])'
		description: 'foo is not overridden'.
	self processQuery:
			' if fails(foobar isOverriddenSelectorInClass: [TestClass4])'
		description: 'selector does not exist'.
	self processQuery:
			' if succeeds(foo isOverriddenSelectorInClass: [SubClass1])'
		description: 'indirect (one class in the hierarchy in between) override'
]

{ #category : #naming }
BasicReasoningTests >> testIsPackageWithName2 [
	
	self processQuery:
			' if succeeds(and(?Package isPackageWithName: ?Name,nonvar(?Package),nonvar(?Name)))'
		description: 'Can we use packageWithName/2 with two arguments unbound?'.
	self processQuery:
			' if succeeds(and(?Package isPackageWithName: [''LiCoR-Tests''],nonvar(?Package)))'
		description: 'Can we find the package with a given name?'.
	self processQuery:
			' if succeeds(and([''LiCoR-Tests''] isPackageWithName: ?Name,nonvar(?Name),?Name equals: [''LiCoR-Tests'']))'
		description:
			'Can we find the name of an existing package, and is it the correct one?'
]

{ #category : #methods }
BasicReasoningTests >> testIsPrimitiveMethod1 [
	
	self processQuery:
			' if fails(and(?method isMethodWithName: anAbstractMethod inClass: [TestClass3],?method isPrimitiveMethod))'
		description:
			'checks that Soul.TestClass3>>anAbstractMethod is not a primitive method'.
	self processQuery:
			' if succeeds(and(?method isMethodWithName: [#==] inClass: [ProtoObject],?method isPrimitiveMethod))'
		description: 'checks that Object>>== is a primitive method'
]

{ #category : #methods }
BasicReasoningTests >> testIsSelector1 [
	
	self processQuery:
			' if not(thisIsUnlikelyToEveryBeTheSelectorOfAMethod isSelector)'
		description:
			'The symbol #thisIsUnlikelyToEveryBeTheSelectorOfAMethod is not the selector of any method'.
	self processQuery: ' if #printOn: isSelector' description:
			'The symbol #printOn: is known to be a selector'
]

{ #category : #methods }
BasicReasoningTests >> testIsSelectorOfClassInProtocol [
	
	self processQuery:
			' if succeeds(?Selector isSelectorOfClass: [TestClass1] inProtocol: ?Protocol)'
		description:
			'Can the predicate isSelectorOfClass:inProtocol:/3 be used to find all method names and protocols in a given class?'.
	self processQuery:
			' if succeeds([#method4] isSelectorOfClass: ?Class inProtocol: ?Protocol)'
		description:
			'Can the predicate isSelectorOfClass:inProtocol:/3 be used to find all classes and protocols that have a method with a given name?'.
	self processQuery:
			' if succeeds(and(?Method isMethodWithName: ?Selector inClass: [TestClass1],?Selector isSelectorOfClass: ?Class inProtocol: ?Protocol,?Class equals: [TestClass1],?Protocol equals: [#protocol1]))'
		description:
			'Can the predicate isSelectorOfClass:inProtocol:/3 be used to find the class and protocol of a given selector?'
]

{ #category : #methods }
BasicReasoningTests >> testIsSourceCodeOfMethod2 [
	
	self processQuery:
			' if ?Method isMethodWithName: array inClass: [TestClass1],?Source isSourceCodeOfMethod: ?Method,[?Source asString] equals:[(TestClass1>>#array) getSource ] ' description: 'Retrieve the source code of this method'
]

{ #category : #'method body' }
BasicReasoningTests >> testIsStatementOfMethod2 [
	
	self processQuery:
			' if succeeds(and(?Method isMethodWithName: methodWithSend inClass: [TestClassRoot],RBMessageNode(RBMessageNode(RBVariableNode(self),methodWithAssignment,<>),first,<>) isStatementOfMethod: ?Method))'
		description: 'This method has a single statement.'.
	self processQuery:
			' if succeeds(and(?Method isMethodWithName: foo inClass: [TestClassRoot],RBReturnNode(?) isStatementOfMethod: ?Method))'
		description: 'This method has a return statement.'.
	self processQuery:
			' if fails(and(?Method isMethodWithName: foo inClass: [SubClass1],?Statement isStatementOfMethod: ?Method))'
		description: 'This method has no statements.'
]

{ #category : #classes }
BasicReasoningTests >> testIsSubclassOf2 [
	
	self processQuery: ' if succeeds([SubClass1] isSubclassOf: [TestClass1])'
		description: 'Is SubClass1 a subclass of TestClass1?'.
	self processQuery: ' if fails([TestClass1] isSubclassOf: [SubClass1])'
		description: 'Is TestClass1 not a subclass of SubClass1?'.
	self
		processQuery: ' if [SubClass1] isSubclassOf: ?C'
		resultsCheck: [:results | results size = 1]
		description: 'Is SubClass1 the subclass of a unique superclass?'.
	self processQuery:
			' if fails(and([MLI current allRootClassEntities] contains: ?Root,?Root isSubclassOf: ?C))'
		description:
			'Does the predicate subclassOf/2 fail for the rootclasses as subclass?'.
	self processQuery: ' if succeeds(?C isSubclassOf: [TestClass1])'
		description: 'Does TestClass1 have at least one subclass?'.
	self processQuery: ' if succeeds(one(?C isSubclassOf: ?S))' description:
			'Can the predicate subclassOf/2 be used with two arguments unbound?'
]

{ #category : #'method body' }
BasicReasoningTests >> testIsTemporaryVariableOfMethod2 [
	
	self processQuery:
			' if fails(and(?Method isMethodWithName: method4 inClass: [TestClass1],?V isTemporaryVariableOfMethod: ?Method))'
		description: 'This method has no temporary variables'.
	self
		processQuery:
			' if ?Method isMethodWithName: commentedMethod3 inClass: [TestClass5],?V isTemporaryVariableOfMethod: ?Method'
		resultsCheck: [:result | result size = 2]
		description: 'This method has two temporary variables'
]

{ #category : #'method body' }
BasicReasoningTests >> testMethodAccessesInstanceVariableInClass3 [
	
	self processQuery:
			' if fails(and(?Method isMethodWithName: foo inClass: [TestClassRoot],?Method methodAccessesInstanceVariable: newString inClass: ?Class))'
		description:
			'This method assigns to the local variable newString; not to an instance variable'.
	self processQuery:
			' if succeeds(and(?Method isMethodWithName: [#array:] inClass: [TestClass1],?Method methodAccessesInstanceVariable: array inClass: ?Class))'
		description: 'This method assigns to the instance variable array'.
	self processQuery:
			' if succeeds(and(?Method isMethodWithName: [#array] inClass: [TestClass1],?Method methodAccessesInstanceVariable: array inClass: [TestClass1]))'
		description: 'This method reads the instance variable array'
]

{ #category : #'method body' }
BasicReasoningTests >> testMethodAssignsInstanceVariableInClass3 [
	
	self processQuery:
			' if fails(and(?Method isMethodWithName: foo inClass: [TestClassRoot],?Method methodAssignsInstanceVariable: newString inClass: ?Class))'
		description:
			'This method assigns to the local variable newString; not to an instance variable'.
	self processQuery:
			' if fails(and(?Method isMethodWithName: foo inClass: [SubClass1],?Method methodAssignsInstanceVariable: newString inClass: ?Class))'
		description: 'This method does not do any assignments'.
	self processQuery:
			' if succeeds(and(?Method isMethodWithName: [#array:] inClass: [TestClass1],?Method methodAssignsInstanceVariable: array inClass: ?Class))'
		description: 'This method assigns to the instance variable array'
]

{ #category : #'method body' }
BasicReasoningTests >> testMethodAssignsVariableExpression3 [
	
	self processQuery:
			' if succeeds(and(?Method isMethodWithName: foo inClass: [TestClassRoot],?Method methodAssignsVariable: newString expression: RBMessageNode(RBVariableNode(self),copy,<>)))'
		description: 'This method assigns to the local variable newString'.
	self processQuery:
			' if fails(and(?Method isMethodWithName: foo inClass: [SubClass1],?Method methodAssignsVariable: ? expression: ?))'
		description: 'This method does not do any assignments'.
	self processQuery:
			' if succeeds(and(?Method isMethodWithName: [#array:] inClass: [TestClass1],?Method methodAssignsVariable: array expression: RBVariableNode(anArray)))'
		description: 'This method assigns to the instance variable array'
]

{ #category : #'method body' }
BasicReasoningTests >> testMethodCallsMethod2 [
	
	self processQuery:
			' if succeeds(and(?Method isMethodWithName: methodWithSend inClass: [TestClassRoot],?Method methodCallsMethod: ?M2,?M2 isMethodWithName: methodWithAssignment,!))'
		description:
			'Verify that this method calls a method named methodWithAssignment'.
	self processQuery:
			' if succeeds(and(?Method isMethodWithName: methodWithSend inClass: [TestClassRoot],?M isMethodWithName: methodWithAssignment inClass: [TestClassRoot],?Method methodCallsMethod: ?M2))'
		description:
			'Verify that this method calls a method named methodWithAssignment'
]

{ #category : #methods }
BasicReasoningTests >> testMethodOverridesMethod2 [
	
	self processQuery:
			' if succeeds(and(?m1 isMethodWithName: foo inClass: [TestClass4],?m2 isMethodWithName: foo inClass: [TestClassRoot],?m1 methodOverridesMethod: ?m2))'
		description: 'Both arguments bound; success'.
	self processQuery:
			' if succeeds(and(?m1 isMethodWithName: foo inClass: [SubClass1],?m2 isMethodWithName: foo inClass: [TestClassRoot],?m1 methodOverridesMethod: ?m2))'
		description: 'Both arguments bound; indirect inheritance; success'.
	self processQuery:
			' if fails(and(?m1 isMethodWithName: foo inClass: [TestClass4],?m2 isMethodWithName: foo inClass: [TestClassRoot],?m2 methodOverridesMethod: ?m1))'
		description: 'Both arguments bound; failure'.
	self processQuery:
			' if succeeds(and(?m1 isMethodWithName: foo inClass: [TestClass4],?m1 methodOverridesMethod: ?m2,?m2 isMethodWithName: foo inClass: [TestClassRoot]))'
		description: 'First argument bound; success'.
	self processQuery:
			' if succeeds(and(?m2 isMethodWithName: foo inClass: [TestClassRoot],?m1 methodOverridesMethod: ?m2,?m1 isMethodWithName: foo inClass: [TestClass4]))'
		description: 'Second argument bound; success'
]

{ #category : #'method body' }
BasicReasoningTests >> testMethodReadsInstanceVariableInClass3 [
	
	self processQuery:
			' if succeeds(and(?Method isMethodWithName: [#array] inClass: [TestClass1],?Method methodReadsInstanceVariable: array inClass: [TestClass1]))'
		description: 'This method reads the instance variable array'.
	self processQuery:
			' if fails(and(?Method isMethodWithName: [#sumWith:] inClass: [TestClass1],?Method methodReadsInstanceVariable: anInteger inClass: [TestClass1]))'
		description: 'anInteger is an argument'.
	self processQuery:
			' if fails(and(?Method isMethodWithName: [#withShadowing] inClass: [TestClass1],?Method methodReadsInstanceVariable: array inClass: [TestClass1]))'
		description: 'array is shadowed'.
	self processQuery:
			' if fails(and(?Method isMethodWithName: [#array:] inClass: [TestClass1],?Method methodReadsInstanceVariable: array inClass: [TestClass1]))'
		description: 'array is written to; not read'
]

{ #category : #'method body' }
BasicReasoningTests >> testMethodReferencesClass2 [
	
	self processQuery:
			' if succeeds(and(?Method isMethodWithName: foo inClass: [TestClass4],?Method methodReferencesClass: [Array]))'
		description: 'Verify that this method refers to the class Array.'.
	self processQuery:
			' if succeeds(and(?Method isMethodWithName: fooFullReference inClass: [TestClass4],?Method methodReferencesClass: [Array]))'
		description:
			'Verify that this method refers to the class Array (now with full reference).'.
	self processQuery:
			' if ?Method isMethodWithName: bar inClass: [TestClass4],fails(?Method methodReferencesClass: [Array])'
		description: 'Verify that this method does not refer to the class Array.'.
	self processQuery:
			' if succeeds(and(?Method isMethodWithName: bar inClass: [TestClass4],?Method methodReferencesClass: [Set]))'
		description: 'Verify that this method refers to the class Set.'.
	self
		processQuery:
			' if ?Method isMethodWithName: zork inClass: [TestClass4],?Method methodReferencesClass: ?Class'
		resultsCheck: [:results | results size = 3]
		description: 'Verify that this method refers to 3 classes.'.
	self processQuery:
			' if fails(and(?method isMethodWithName: method6 inClass: [TestClass5],?method methodReferencesClass: ?class))'
		description:
			'Verify that TestClass1>>method6 does not reference any class, even though it uses the global variable ThisIsAGlobalVariableThatDoesNotReferenceAClass'.
	self processQuery: ' if fails(foo methodReferencesClass: zork)'
		description:
			'Does the methodReferencesClass predicate handles bad information gracefully?'
]

{ #category : #'method body' }
BasicReasoningTests >> testMethodReturnsBoolean2 [
	
	self processQuery:
			' if succeeds(and(?Method isMethodWithName: isNode inClass: [Node],?Method methodReturnsBoolean: [true]))'
		description: 'This method return true'.
	self processQuery:
			' if succeeds(and(?Method isMethodWithName: isNode inClass: [Tree],?Method methodReturnsBoolean: [false]))'
		description: 'This method return false'.
	self processQuery:
			' if fails(and(?Method isMethodWithName: foo inClass: [TestClassRoot],?Method methodReturnsBoolean: ?))'
		description: 'This method returns a complex statement'.
	self processQuery:
			' if fails(and(?Method isMethodWithName: foo inClass: [SubClass1],?Method methodReturnsBoolean: ?))'
		description: 'This method does not return anything'
]

{ #category : #'method body' }
BasicReasoningTests >> testMethodReturnsExpression2 [
	
	self processQuery:
			' if fails(and(?Method isMethodWithName: methodWithSend inClass: [TestClassRoot],?Method methodReturnsExpression: ?Exp))'
		description: 'This method has a single non-return, statement.'.
	self processQuery:
			' if succeeds(and(?Method isMethodWithName: foo inClass: [TestClassRoot],?Method methodReturnsExpression: ?Exp))'
		description: 'This method has a return statement.'.
	self processQuery:
			' if fails(and(?Method isMethodWithName: foo inClass: [SubClass1],?Method methodReturnsExpression: ?Exp))'
		description: 'This method has no statements.'.
	self
		processQuery:
			' if ?Method isMethodWithName: [#complexWith:and:and:and:] inClass: [TestClassRoot],?Method methodReturnsExpression: ?Exp'
		resultsCheck: [:result | result size = 5]
		description: 'This method has multiple returns.'
]

{ #category : #'method body' }
BasicReasoningTests >> testMethodSendsSelector2 [
	
	self processQuery:
			' if succeeds(and(?Method isMethodWithName: foo inClass: [TestClassRoot],?Method methodSendsSelector: zork))'
		description: 'Verify that this method sends message #zork'.
	self processQuery:
			' if succeeds(and(?Method isMethodWithName: foo inClass: [TestClassRoot],?Method methodSendsSelector: copy))'
		description: 'Verify that this method sends message #copy'.
	self processQuery:
			' if fails(and(?Method isMethodWithName: foo inClass: [TestClassRoot],?Method methodSendsSelector: HIGHLYUNLIKELY))'
		description:
			'Verify that this method does not send message #HIGHLYUNLIKELY'.
	self processQuery:
			' if fails(and(?Method isMethodWithName: methodWithSimpleReturn inClass: [TestClassRoot],?Method methodSendsSelector: ?s))'
		description: 'Verify that this method does not send any messages'
]

{ #category : #'method body' }
BasicReasoningTests >> testMethodWithUniqueStatement2 [
	
	self processQuery:
			' if succeeds(and(?Method isMethodWithName: methodWithSend inClass: [TestClassRoot],?Method methodWithUniqueStatement: RBMessageNode(RBMessageNode(RBVariableNode(self),methodWithAssignment,<>),first,<>)))'
		description: 'This method has a single statement.'.
	self processQuery:
			' if fails(and(?Method isMethodWithName: foo inClass: [TestClassRoot],?Method methodWithUniqueStatement: ?Statement))'
		description: 'This method has multiple statements'.
	self processQuery:
			' if fails(and(?Method isMethodWithName: foo inClass: [SubClass1],?Method methodWithUniqueStatement: ?Statement))'
		description: 'This method has no statements.'
]

{ #category : #methods }
BasicReasoningTests >> testisAbstractMethodInClass2 [
	
	self processQuery:
			' if succeeds(and(?method isAbstractMethodInClass: [TestClass3],?method isMethodWithName: anAbstractMethod))'
		description:
			'checks whether Soul.TestClass3>>anAbstractMethod is an abstract method'.
	self processQuery:
			' if succeeds(and(?method isAbstractMethodInClass: [TestClass3],?method isMethodWithName: anotherAbstractMethod))'
		description:
			'checks whether Soul.TestClass3>>anotherAbstractMethod is an abstract method'
]
