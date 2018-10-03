"
self suite run

"
Class {
	#name : #SmalltalkReificationTests,
	#superclass : #LiCoRTests,
	#category : 'LiCoR-Tests'
}

{ #category : #entities }
SmalltalkReificationTests >> testIsBaseClass1 [
	
	self
		processQuery: ' if ?c isBaseClass'
		resultsCheck:
			[:results | results size = MLI current allBaseClassEntities size]
		description:
			'Is the number of returned base classes equal to what is expected?'.
	self processQuery: ' if succeeds([TestClass1] isBaseClass)' description:
			'Is TestClass1 a base class?'.
	self processQuery: ' if fails(1 isBaseClass)' description:
			'Does baseClass/1 fail for an expression that is not a base class?'.
	self processQuery: ' if fails([TestClass1 class] isBaseClass)'
		description: 'Is the meta class of TestClass1 NOT a base class?'.
	self processQuery:
			' if succeeds(and(member(?C,[TestClassRoot allSubclasses]),forall(?C isBaseClass,not(?C isMetaClass))))'
		description:
			'Is no base class a meta class? (restricted to TestClassRoot hierarchy for performance reasons)'.
	self processQuery:
			' if succeeds(and(member(?C,[TestClassRoot allSubclasses]),forall(?C isBaseClass,?C isClass)))'
		description:
			'Is every base class a class? (restricted to TestClassRoot hierarchy for performance reasons)'
]

{ #category : #entities }
SmalltalkReificationTests >> testIsClass1 [
	
	self processQuery: ' if succeeds([TestClass1] isClass)' description:
			'Is TestClass1 a class?'.
	self processQuery: ' if fails(1 isClass)' description:
			'Does isClass fail on an expression that is not a class?'.
	self processQuery: ' if succeeds([TestClass1 class] isClass)' description:
			'Is the meta class of TestClass1 a class?'
]

{ #category : #'binary relations' }
SmalltalkReificationTests >> testIsClassMethodInClass2 [
	
	self
		processQuery:
			' if ?method isClassMethodInClass: [TestClass1],?method isMethod'
		resultsCheck: [:results | results size = 2]
		description:
			'Can we extract all class methods from a class and are they all methods?'.
	self processQuery:
			' if ?m isMethod,?m isClassMethodInClass: ?class,!,equals([?m fromClass],[?class class])'
		description: 'Can we extract the class from a class method?'.
	self processQuery: ' if succeeds(?method isClassMethodInClass: ?class)'
		description: 'Can we extract classMethodInClass relations?'.
	self processQuery:
			' if fails(and(?method isClassMethodInClass: [TestClass1],?method isClassMethodInClass: [AbstractTerm]))'
		description: 'Can we check if a method is not in class'.
	self processQuery:
			' if fails(and(foo isClassMethodInClass: ?class,?method isClassMethodInClass: foo,foo isClassMethodInClass: foo))'
		description:
			'Does methodInClass fail when given something else than a method or a class?'.
	self processQuery:
			' if ?method1 isMethod,?method1 isClassMethodInClass: ?class,!,findall(?method2,?method2 isClassMethodInClass: ?class,?list),member(?method1,?list)'
		description:
			'Basic sanity test for classMethodInClass: all solutions when ?method is bound should also be solutions when ?method is unbound.'
]

{ #category : #entities }
SmalltalkReificationTests >> testIsClassVariable1 [
	
	self processQuery: ' if fails([#fooujhqdghjqdvsb] isClassVariable)'
		description: 'Does no class variable with this name exist?'.
	self processQuery: ' if succeeds(?V isClassVariable)' description:
			'Can the predicate be used to extract instance variable names?'.
	self processQuery: ' if succeeds(one([#mcivar1] isClassVariable))'
		description: 'Does a class variable with this name exist?'.
	self processQuery: ' if fails([#iv1] isClassVariable)' description:
			'Is iv1 not a class variable? (It is an instance variable.)'
]

{ #category : #'binary relations' }
SmalltalkReificationTests >> testIsClassVariableInClass2 [
	
	self processQuery: ' if fails(?IV isClassVariableInClass: [TestClass3])'
		description: 'Does TestClass3 have class variables => no?'.
	self processQuery:
			' if succeeds(?IV isClassVariableInClass: [TestClass1])' description:
			'Does TestClass1 have at least one instance variable?'.
	self processQuery:
			' if succeeds([#mcivar1] isClassVariableInClass: [TestClass1])'
		description: 'Does TestClass1 have an class variable named mcivar1?'.
	self processQuery:
			' if fails([#fooujhqdghjqdvsb] isClassVariableInClass: [TestClass1])'
		description:
			'Does TestClass1 have no class variable with this absurd name?'.
	self processQuery:
			' if succeeds([#mcivar1] isInstanceVariableInClass: ?C)' description:
			'Are there classes with class variable named mcivar1?'.
	self processQuery: ' if succeeds(?IV isClassVariableInClass: ?C)'
		description:
			'Can we use the predicate isClassVariableInClass/2 with two arguments unbound?'.
	self processQuery: ' if fails(1 isClassVariableInClass: [TestClass1])'
		description:
			'Does the predicate isClassVariableInClass/2 fail when a number is provided as variable name?'.
	self processQuery: ' if fails([#iv1] isClassVariableInClass: 1)'
		description:
			'Does the predicate isClassVariableInClass/2 fail when a number is provided as class name?'
]

{ #category : #entities }
SmalltalkReificationTests >> testIsInstanceVariable1 [
	
	self processQuery: ' if succeeds([#iv1] isInstanceVariable)' description:
			'Does an instance variable with this name exist?'.
	self processQuery: ' if fails([#fooujhqdghjqdvsb] isInstanceVariable)'
		description: 'Does no instance variable with this name exist?'.
	self processQuery: ' if succeeds(one(?IV isInstanceVariable))'
		description:
			'Can the predicate be used to extract instance variable names?'.
	self processQuery: ' if fails([#mcivar1] isInstanceVariable)' description:
			'Is mcivar1 not an instance variable? (It is a class variable.)'
]

{ #category : #'binary relations' }
SmalltalkReificationTests >> testIsInstanceVariableInClass2 [
	
	self processQuery:
			' if fails(?IV isInstanceVariableInClass: [TestClass3])' description:
			'Does TestClass3 have no instance variables?'.
	self processQuery:
			' if succeeds(?IV isInstanceVariableInClass: [TestClass1])' description:
			'Does TestClass1 have at least one instance variable?'.
	self processQuery:
			' if succeeds([#iv1] isInstanceVariableInClass: [TestClass1])'
		description: 'Does TestClass1 have an instance variable named iv1?'.
	self processQuery:
			' if fails([#fooujhqdghjqdvsb] isInstanceVariableInClass: [TestClass1])'
		description:
			'Does TestClass1 have no instance variable with this absurd name?'.
	self processQuery: ' if succeeds([#iv1] isInstanceVariableInClass: ?C)'
		description:
			'Can we use the predicate instanceVariableInClass/2 to extract classes with a give instance variable name?'.
	self processQuery: ' if succeeds(?IV isInstanceVariableInClass: ?C)'
		description:
			'Can we use the predicate instanceVariableInClass/2 with two arguments unbound?'.
	self processQuery: ' if fails(1 isInstanceVariableInClass: [TestClass1])'
		description:
			'Does the predicate instanceVariableInClass/2 fail when a number is provided as variable name?'.
	self processQuery: ' if fails([#iv1] isInstanceVariableInClass: 1)'
		description:
			'Does the predicate instanceVariableInClass/2 fail when a number is provided as class name?'
]

{ #category : #'binary relations' }
SmalltalkReificationTests >> testIsInstanceVariableInClassChainOf2 [
	
	self processQuery:
			' if succeeds(and(?IV isInstanceVariableInClassChainOf: [TestClass1],nonvar(?IV)))'
		description:
			'Does TestClass1 have an instance variable in its class chain? (This is a trivial case as TestClass1 implements instance variables itself.)'.
	self processQuery:
			' if succeeds(and(?IV isInstanceVariableInClassChainOf: [SubClass1],nonvar(?IV)))'
		description:
			'Does SubClass1, which does not declare any instance variables itself, indirectly has an instance variable?'.
	self processQuery:
			' if fails(?IV isInstanceVariableInClassChainOf: [TestClass3])'
		description:
			'Does TestClass3, nor any of its superclasses declare instance variables?'.
	self processQuery:
			' if succeeds([#iv2] isInstanceVariableInClassChainOf: [TestClass1])'
		description:
			'Does TestClass1 have the instance variable iv2 in its class chain? (This is a trivial case as TestClass1 implements the instance variable itself.)'.
	self processQuery:
			' if succeeds([#iv2] isInstanceVariableInClassChainOf: [SubClass2])'
		description:
			'Does SubClass2, which does not declare any instance variables itself, indirectly has an instance variable iv2?'.
	self processQuery:
			' if fails([#fooujhqdghjqdvsb] isInstanceVariableInClassChainOf: [SubClass2])'
		description:
			'Does Subclass2 have no (direct or indirect) instance variable fooujhqdghjqdvsb?'.
	self processQuery:
			' if succeeds(and([#array] isInstanceVariableInClassChainOf: ?C,nonvar(?C)))'
		description:
			'Can we use the predicate to extract classes that (directly or indirectly) have a given instance variable name?'.
	self processQuery:
			' if succeeds(and([#iv2] isInstanceVariableInClassChainOf: ?C,nonvar(?C),equals(?C,[TestClass1])))'
		description:
			'When using instanceVariableInClassChain/2 with the class unbound, does it return the class that (directly) declares the instance variable?'.
	self processQuery:
			' if succeeds(and([#iv2] isInstanceVariableInClassChainOf: ?C,nonvar(?C),equals(?C,[SubClass2])))'
		description:
			'When using instanceVariableInClassChain/2 with the class unbound, can it return a classes that indirectly has the instance variable?'.
	self processQuery:
			' if succeeds(and(?IV isInstanceVariableInClassChainOf: ?C,nonvar(?IV),nonvar(?C)))'
		description: 'Can we use the predicate with two arguments unbound?'
]

{ #category : #'binary relations' }
SmalltalkReificationTests >> testIsInstanceVariableInMetaClass2 [
	
	self processQuery:
			' if succeeds(one(and(?V isInstanceVariableInMetaClass: ?C,nonvar(?V),nonvar(?C))))'
		description:
			'Does isInstanceVariable:InMetaClass:/2 work with two variables?'.
	self processQuery:
			' if succeeds(and(?V isInstanceVariableInMetaClass: [TestClass1 class],nonvar(?V)))'
		description:
			'Does the meta class of TestClass1 have at least one instance variable?'.
	self processQuery:
			' if fails(?V isInstanceVariableInMetaClass: [TestClass3 class])'
		description:
			'Does the meta class of TestClass3 have no instance variables?'.
	self processQuery:
			' if succeeds([#mcivar1] isInstanceVariableInMetaClass: [TestClass1 class])'
		description:
			'Does the meta class of TestClass1 have an instance variable mcivar1?'.
	self processQuery:
			' if succeeds(and([#mcivar1] isInstanceVariableInMetaClass: ?C,nonvar(?C)))'
		description:
			'Can we find a class of which the meta class has an instance variable named mcivar1?'
]

{ #category : #'binary relations' }
SmalltalkReificationTests >> testIsInstanceVariableInMetaClassChainOf2 [
	"self run: #testinstanceVariableInMetaClassChain2"

	
	self processQuery:
			' if succeeds(one(and(?V isInstanceVariableInMetaClassChainOf: ?C,nonvar(?V),nonvar(?C))))'
		description: 'Can we find solutions?'.
	self processQuery:
			' if succeeds(and(?V isInstanceVariableInMetaClassChainOf: [SubClass1 class],nonvar(?V)))'
		description:
			'Does the meta class of SubClass1 have at least one instance variable (either directly or indirectly)?'.
	self processQuery:
			' if succeeds([#mcivar1] isInstanceVariableInMetaClassChainOf: [TestClass1 class])'
		description:
			'Does the meta class of TestClass1 have an instance variable mcivar1 (either directly or indirectly)? (This is the trivial case because the meta class of TestClass1 itself declares the instance variable.'.
	self processQuery:
			' if succeeds([#mcivar1] isInstanceVariableInMetaClassChainOf: [SubClass1 class])'
		description:
			'Does the meta class of SubClass1, which does not declare any instance variables, indirectly have an instance variable mcivar1?'.
	self processQuery:
			' if succeeds(and([#mcivar1] isInstanceVariableInMetaClassChainOf: ?C,nonvar(?C)))'
		description:
			'Can we find a class of which the meta class has an instance variable mcivar1 (either directly or indirectly)?'.
	self processQuery:
			' if succeeds(and([#mcivar1] isInstanceVariableInMetaClassChainOf: ?C,nonvar(?C),?C equals: [TestClass1 class]))'
		description:
			'Can we find a class of which the meta class (directlty or indirectly) has an instance variable mcivar1 (either directly or indirectly), and is TestClass1 one of the returned results?'.
	self processQuery:
			' if succeeds(and([#mcivar1] isInstanceVariableInMetaClassChainOf: ?C,nonvar(?C),?C equals: [SubClass1 class]))'
		description:
			'Can we find a class of which the meta class (directlty or indirectly) has an instance variable mcivar1 (either directly or indirectly), and is SubClass1 one of the returned results?'
]

{ #category : #entities }
SmalltalkReificationTests >> testIsMetaClass1 [
	
	self
		processQuery: ' if ?C isMetaClass'
		resultsCheck:
			[:results | results size = MLI current allMetaClassEntities size]
		description: 'There are as many meta classes as expected'.
	self processQuery: ' if succeeds([TestClass1 class] isMetaClass)'
		description: 'Is <Soul.SoulTests.TestClass1 class> a meta class?'.
	self processQuery: ' if fails([TestClass1] isMetaClass)' description:
			'Is Soul.SoulTests.TestClass1 NOT a meta class?'.
	self processQuery: ' if fails(1 isMetaClass)' description:
			'Is a number NOT a meta class?'.
	self processQuery:
			' if succeeds(and(member(?C,[TestClassRoot allSubclasses]),equals(?MC,[?C class]),forall(?MC isMetaClass,not(?MC isBaseClass))))'
		description:
			'Is no meta class a base class? (restricted to the hierarchy of TestClassRoot for performance reasons)'.
	self processQuery:
			' if succeeds(and(member(?C,[TestClassRoot allSubclasses]),equals(?MC,[?C class]),forall(?MC isMetaClass,?MC isClass)))'
		description:
			'Is every meta class a class? (restricted to the hierarchy of TestClassRoot for performance reasons)'
]

{ #category : #'binary relations' }
SmalltalkReificationTests >> testIsMetaClassOf2 [
	
	self processQuery:
			' if succeeds([TestClass1 class] isMetaClassOf: [TestClass1])'
		description:
			'Is <Soul.SoulTests.TestClass1 class> the meta class of Soul.SoulTests.TestClass1?'.
	self processQuery:
			' if succeeds([TestClass1 class class] isMetaClassOf: [TestClass1 class])'
		description:
			'Is <Soul.SoulTests.TestClass1 class class> the meta class of Soul.SoulTests.TestClass1 class?'.
	self processQuery:
			' if succeeds(forall([TestClass1 class] isMetaClassOf: ?C,equals(?C,[TestClass1])))'
		description:
			'Is <Soul.SoulTests.TestClass1 class> the only meta class of Soul.SoulTests.TestClass1?'.
	self processQuery:
			' if succeeds(forall(?M isMetaClassOf: [TestClass1],equals(?M,[TestClass1 class])))'
		description:
			'Is Collection the only base class of <Soul.SoulTests.TestClass1 class>?'
]

{ #category : #entities }
SmalltalkReificationTests >> testIsMethod1 [
	
	self
		processQuery: ' if ?M isMethod'
		resultsCheck:
			[:results | 
			| mResults |
			mResults := results resultsForVariableNamed: 'M'.
			(mResults
				contains:
					[:sm | 
					sm smalltalkValue fromClass = TestClassRoot
						and: [sm smalltalkValue selector = #doNotOverride]])
				and:
					[mResults
						contains:
							[:sm | 
							sm smalltalkValue fromClass = TestClassRoot class
								and: [sm smalltalkValue selector = #aClassMethod]]]]
		description:
			'Can we find that Soul.TestClassRoot>>#doNotOverride and Soul.TestClassRoot class>>#aClassMethod belong to all methods?'.
	self processQuery: ' if one(?m isMethod),?m isMethod' description:
			'Is each method we can get from the method predicate really a method?'.
	self processQuery:
			' if [(MLI current methodsInClass: TestClassRoot)
	detect: [:m | m selector = #doNotOverride]] isMethod' description:
			'Can we find that Soul.TestClassRoot>>#doNotOverride is indeed a method?'.
	self processQuery:
			' if [(MLI current methodsInClass: TestClassRoot class)
	detect: [:m | m selector = #aClassMethod]] isMethod' description:
			'Can we find that Soul.TestClassRoot class>>#aClassMethod is indeed a method?'.
	self processQuery: ' if fails(foobar isMethod)' description:
			'Are other things not recognized as methods?'
]

{ #category : #'binary relations' }
SmalltalkReificationTests >> testIsMethodInClass2 [
	
	self
		processQuery:
			' if ?method isMethodInClass: [TestClass1],?method isMethod'
		resultsCheck: [:results | results size = 9]
		description:
			'Can we extract all methods from a class and are they all methods?'.
	self processQuery:
			' if one(?m isMethod),?m isMethodInClass: ?class,equals([?m fromClass],?class)'
		description: 'Can we extract the class from a method?'.
	self processQuery:
			' if one(?m isMethod),equals([?m fromClass],?class),?m isMethodInClass: ?class'
		description: 'Can we check a methodInClass relation?'.
	self processQuery: ' if succeeds(?method isMethodInClass: ?class)'
		description: 'Can we extract methodInClass relations?'.
	self processQuery:
			' if fails(and(?method isMethodInClass: [TestClass1],?method isMethodInClass: [AbstractTerm]))'
		description: 'Can we check if a method is not in class'.
	self processQuery:
			' if fails(and(foo isMethodInClass: ?class,?method isMethodInClass: foo,foo isMethodInClass: foo))'
		description:
			'Does methodInClass fail when given something else than a method or a class?'.
	self processQuery:
			' if one(?method1 isMethod),?method1 isMethodInClass: ?class,findall(?method2,?method2 isMethodInClass: ?class,?list),member(?method1,?list)'
		description:
			'Basic sanity test for methodInClass: all solutions when ?method is bound should also be solutions when ?method is unbound.'
]

{ #category : #'method attributes' }
SmalltalkReificationTests >> testIsParseTreeOfMethod2 [
	
	self processQuery: ' if succeeds(one(?tree isParseTreeOfMethod: ?method))'
		description: 'We do find a parse tree of a method'.
	self processQuery:
			' if equals(?method,[(MLI current methodsInClass: TestClassRoot)
	detect: [:m | m selector = #doNotOverride]]),?tree isParseTreeOfMethod: ?method,succeeds([?tree isKindOf: RBMethodNode])'
		description: 'Can we find the parse tree of TestClassRoot>>doNotOverride'
]

{ #category : #entities }
SmalltalkReificationTests >> testIsRootClass1 [
	
	self processQuery: ' if succeeds(?X isRootClass)' description:
			'Is there at least one root class?'.
	self processQuery: ' if fails([TestClass1] isRootClass)' description:
			'isRootClass is supposed to fail on a non rootclass'
]

{ #category : #'method attributes' }
SmalltalkReificationTests >> testIsSourceCodeOfMethod2 [
	
	self processQuery:
			' if succeeds(one(?code isSourceCodeOfMethod: ?method))' description:
			'We do find the source code of a method'.
	self processQuery:
			' if equals(?method,[(MLI current methodsInClass: TestClassRoot)
	detect: [:m | m selector = #doNotOverride]]),?code isSourceCodeOfMethod: ?method,succeeds([?code asString =
		(TestClassRoot>>#doNotOverride) getSource ])' description:
			'Can we find the source code of TestClassRoot>>doNotOverride'
]

{ #category : #'binary relations' }
SmalltalkReificationTests >> testIsSuperclassOf2 [
	
	self processQuery:
			' if succeeds([TestClass1] isSuperclassOf: [SubClass1])' description:
			'Is TestClass1 the superclass of SubClass1?'.
	self processQuery: ' if fails([SubClass1] isSuperclassOf: [TestClass1])'
		description: 'Is SubClass1 not the superclass of TestClass1?'.
	self
		processQuery: ' if ?C isSuperclassOf: [SubClass1]'
		resultsCheck: [:results | results size = 1]
		description: 'Does SubClass1 have a unique superclass?'.
	self processQuery: ' if succeeds([TestClass1] isSuperclassOf: ?C)'
		description: 'Does TestClass1 have at least one subclass?'.
	self processQuery: ' if succeeds(?S isSuperclassOf: ?C)' description:
			'Can the predicate be used with two arguments unbound?'
]

{ #category : #'method attributes' }
SmalltalkReificationTests >> testMethodContainsSourceComment2 [
	
	self processQuery:
			' if ?method isMethodInClass: [TestClass5],[?method selector = #commentedMethod3],?method methodContainsSourceComment: [''Smalltalk'']'
		description:
			'The method TestClass5>>commentedMethod3 has a comment "Smalltalk"'.
	self processQuery:
			' if ?method isMethodInClass: [TestClass5],[?method selector = #commentedMethod3],?method methodContainsSourceComment: [''Smalltalk''],?method methodContainsSourceComment: [''is''],?method methodContainsSourceComment: [''fun'']'
		description:
			'The method TestClass5>>commentedMethod3 has the three comments "Smalltalk", "is" and "fun" '.
	self processQuery:
			' if ?method isMethodInClass: [TestClass5],[?method selector = #commentedMethod3],not(?method methodContainsSourceComment: [''Java''])'
		description:
			'The method TestClass5>>commentedMethod3 does not have a comment "Java"'.
	self processQuery:
			' if ?method isMethodInClass: [TestClass5],[?method selector = #commentedMethod0],not(?method methodContainsSourceComment: ?comment)'
		description: 'The method TestClass5>>commentedMethod0 has no comments.'
]

{ #category : #'method attributes' }
SmalltalkReificationTests >> testMethodHasAnnotationWithValues3 [
	
	self processQuery:
			' if ?method isMethodInClass: [TestClassWithAttributedMethod],[?method selector = #method1],?method methodHasAnnotation: #test: withValues: <itsatest>'
		description:
			'The method TestClassWithAttributedMethod>>method1 has an attribute test with value #itsatest'.
	self processQuery:
			' if ?method isMethodInClass: [TestClassWithAttributedMethod],?method methodHasAnnotation: #test: withValues: <itsatest>,[?method selector = #method1]'
		description:
			'One of the methods with attribute test with value #itsatest is the method TestClassWithAttributedMethod>>method1 (tests leaving the ?method argument unbound)'.
	self processQuery:
			' if ?method isMethodInClass: [TestClassWithAttributedMethod],[?method selector = #method1],not(?method methodHasAnnotation: ?key withValues: ?values,not(equals(?key,#test:)),not(equals(?values,<itsatest>)))'
		description:
			'The method TestClassWithAttributedMethod>>method1 doesnt have any attributes whose key is not #test or whose value is not #itsatest'.
	self processQuery:
			' if ?method isMethodInClass: [TestClassWithAttributedMethod],[?method selector = #method2],?method methodHasAnnotation: #symbol: withValues: <asymbol>'
		description:
			'The method TestClassWithAttributedMethod>>method2 has an attribute symbol -> #asymbol.'.
	self processQuery:
			' if ?method isMethodInClass: [TestClassWithAttributedMethod],[?method selector = #method2],?method methodHasAnnotation: ?key withValues: <[''A String'']>'
		description:
			'The method TestClassWithAttributedMethod>>method2 has an attribute with value ''A String'' '.
	self processQuery:
			' if ?method isMethodInClass: [TestClassWithAttributedMethod],[?method selector = #method2],?method methodHasAnnotation: #x:y: withValues: <1,2>'
		description:
			'The method TestClassWithAttributedMethod>>method2 has an attribute key x:y: and values 1 and 2'.
	self processQuery:
			' if ?method isMethodInClass: [TestClassWithAttributedMethod],[?method selector = #method2],?method methodHasAnnotation: ?key withValues: <[#(1 #a ''test'')]>'
		description:
			'The method TestClassWithAttributedMethod>>method2 has an attribute with value #(1 a ''test'').'
]
