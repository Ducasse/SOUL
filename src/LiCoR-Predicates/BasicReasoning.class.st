"
This layer contains some rather primitive predicates for reasoning about source code entities and their relations. However, they are not primitive in the sense that they can be written in terms of the predicates provided by the underlying layers of Reification and ParsetreeTraversal. For this reason we define them in a separate layer.
"
Class {
	#name : #BasicReasoning,
	#superclass : #SmalltalkReasoning,
	#category : 'LiCoR-Predicates'
}

{ #category : #methods }
BasicReasoning >> areArgumentsOfMethodXM2 [

"Retrieve the list of ?Arguments of a ?Method"

?Arguments areArgumentsOfMethod: ?Method if 
	?Method isMethod, RBMethodNode(?,?Arguments,?) isParseTreeOfMethod: ?Method
]

{ #category : #'method body' }
BasicReasoning >> areStatementsOfMethodXM2 [

"Retrieve the ?Statements of a ?Method"

?Statements areStatementsOfMethod: ?Method if 
	?Method isMethod,RBMethodNode(?,?,RBSequenceNode(?,?Statements)) isParseTreeOfMethod: ?Method
]

{ #category : #classes }
BasicReasoning >> classCallsMethodXM2 [

"Find all methods ?Method that potentially get called from within ?Class"

?Class classCallsMethod: ?Method if 
	?Caller isMethodInClass: ?Class,?Caller methodCallsMethod: ?Method
]

{ #category : #classes }
BasicReasoning >> classImplementsSelectorXM2 [

"Does ?Class implement a method with selector ?Selector"

?Class classImplementsSelector: ?Selector if 
	?Class isClass,? isMethodWithName: ?Selector inClass: ?Class
]

{ #category : #classes }
BasicReasoning >> classInheritsFromXM2 [

"The class ?Sub belongs to the class hierarchy below ?Super, but excluding the class ?Super itself."

?Sub classInheritsFrom: ?Super if 
	?Sub isClassInHierarchyOf: ?Super,not(?Sub equals: ?Super)
]

{ #category : #naming }
BasicReasoning >> classMethodWithNameInClassM3 [

"defines the name (selector) of a CLASS method in a class."

classMethodWithNameInClass(?method,?selector,?class) if 
	classMethodInClass(?method,?class),methodWithName(?method,?selector)
]

{ #category : #classes }
BasicReasoning >> classUnderstandsSelectorXM2 [

"Class ?Class understands a message with selector ?Selector.
So the class implements the selector itself, or it is implemented by one of its superclasses.

Case 1: ?Selector is bound"

?Class classUnderstandsSelector: +?Selector if 
	?Class isClass,[MLI forSmalltalk class: ?Class understands: ?Selector].
"Class ?Class understands a message with selector ?Selector.
So the class implements the selector itself, or it is implemented by one of its superclasses.

Case 2: ?Selector is not bound"

?Class classUnderstandsSelector: -?Selector if 
	?Class isClass,[MLI forSmalltalk allSelectorsUnderstoodByClass: ?Class] contains: ?Selector
]

{ #category : #naming }
BasicReasoning >> classVariableWithNameM2 [

"defines the name of a class variable"

classVariableWithName(?ClassVariable,?name) if 
	classVariable(?ClassVariable),equals(?name,[MLI current classVariableNameOf: ?ClassVariable])
]

{ #category : #naming }
BasicReasoning >> instanceVariableWithNameM2 [

"defines the name of an instance variable"

instanceVariableWithName(?instanceVariable,?name) if 
	instanceVariable(?instanceVariable),equals(?name,[MLI current instanceVariableNameOf: ?instanceVariable])
]

{ #category : #classes }
BasicReasoning >> isAbstractClassM1 [

"A class ?Class is an abstract class if it has an abstract method in its class chain that is not overridden"

?Class isAbstractClass if 
	?Method isMethodInClassChainOfClass: ?Class,?Method isAbstractMethod,not(and(?M2 isMethodInClassChainOfClass: ?Class,?M2 methodOverridesMethod: ?Method))
]

{ #category : #methods }
BasicReasoning >> isAbstractMethodInClassXM2 [

"The class ?Class implements an abstract method ?Method "

?Method isAbstractMethodInClass: ?Class if 
	?Method isMethodInClass: ?Class,?Method isAbstractMethod
]

{ #category : #methods }
BasicReasoning >> isAbstractMethodM1 [

"Is method ?Method an abstract method?"

?Method isAbstractMethod if 
	?Method isMethod,[?Method isAbstract]
]

{ #category : #methods }
BasicReasoning >> isCancelledMethodM1 [

"Is method ?Method cancelled, meaning that it should not be implemented?"

?Method isCancelledMethod if 
	?Method isMethod,[?Method isCancelled]
]

{ #category : #classes }
BasicReasoning >> isClassAboveXM2 [

"The class ?Super is a superclass in the hierarchy above ?Class, but excluding the class ?Class itself."

?Super isClassAbove: ?Class if 
	?Class classInheritsFrom: ?Super
]

{ #category : #classes }
BasicReasoning >> isClassBelowXM2 [

"The class ?Class is a subclass in the hierarchy below ?Super, but excluding the class ?Super itself."

?Class isClassBelow: ?Super if 
	?Class classInheritsFrom: ?Super
]

{ #category : #classes }
BasicReasoning >> isClassInHierarchyOfXM2 [

"The class ?Sub is a class in the hierarchy of class ?Root (including that rootclass)
Case 1: Both ?Sub and ?Root are bound"

+?Sub isClassInHierarchyOf: +?Root if 
	?Sub isClass,?Root isClass,[MLI current is: ?Sub below: ?Root].
"The class ?Sub is a class in the hierarchy of class ?Root (including that rootclass)
Case 2: ?Sub is bound; ?Root is not bound"

+?Sub isClassInHierarchyOf: -?Root if 
	?Sub isClass,[MLI current allSuperclassesOf: ?Sub] contains: ?Root.
"The class ?Sub is a class in the hierarchy of class ?Root (including that rootclass)
Case 3: ?Sub is not bound; ?Root is  bound"

-?Sub isClassInHierarchyOf: +?Root if 
	?Root isClass,[MLI current allSubclassesOf: ?Root] contains: ?Sub.
"The class ?Sub is a class in the hierarchy of class ?Root (including that rootclass)
Case 4: ?Sub and ?Root are not bound"

-?Sub isClassInHierarchyOf: -?Root if 
	?Root isClass,?Sub isClassInHierarchyOf: ?Root
]

{ #category : #naming }
BasicReasoning >> isClassInPackageNamedXM2 [

"Class ?Class is defined in a package named ?PackageName
CASE 1: ?PackageName is bound"

?Class isClassInPackageNamed: +?PackageName if 
	?Package isPackageWithName: ?PackageName,?Class isClassInPackage: ?Package.
"Class ?Class is defined in a package named ?PackageName
CASE 2: ?PackageName is not bound"

?Class isClassInPackageNamed: -?PackageName if 
	?Class isClassInPackage: ?Package,?Package isPackageWithName: ?PackageName
]

{ #category : #methods }
BasicReasoning >> isClassMethodM1 [

"Is the ?Method a class method?"

?Method isClassMethod if 
	?Method isMethodInClass: ?Class,?Class isMetaClass
]

{ #category : #naming }
BasicReasoning >> isClassWithNameXM2 [

"The class ?Class is named ?ClassName.
CASE 1:?ClassName is bound"

?Class isClassWithName: +?ClassName if 
	[MLI current classesFor: ?ClassName asString] contains: ?Class.

"The class ?Class is named ?ClassName.
CASE 2:?ClassName is not bound"

?Class isClassWithName: -?ClassName if 
	?Class isClass,?ClassName equals: [MLI current classNameOf: ?Class]
]

{ #category : #'method body' }
BasicReasoning >> isLastMessageInCascadeXM2 [

"Is ?Selector the last message that is sent in a ?Cascade?"

?Selector isLastMessageInCascade: RBCascadeNode(?MsgNodes) if 
	?LastMsgNode lastMemberOf: ?MsgNodes,RBMessageNode(?,?Selector,?) equals: ?LastMsgNode
]

{ #category : #methods }
BasicReasoning >> isMethodInClassChainOfClassXM2 [

"Returns all methods ?Method implemented in the class chain of ?Class (either by ?Class itself or by any of its superclasses)

Case 1: ?Class implements ?Method itself"

?Method isMethodInClassChainOfClass: ?Class if 
	?Method isMethodInClass: ?Class.
"Returns all methods ?Method implemented in the class chain of ?Class (either by ?Class itself or by any of its superclasses)

Case 2: A superclass of ?Class implements ?Method"

?Method isMethodInClassChainOfClass: ?Class if 
	?Superclass isClassAbove: ?Class,?Method isMethodInClass: ?Superclass
]

{ #category : #methods }
BasicReasoning >> isMethodInClassXinProtocolXM3 [

"Is ?Method of class ?Class classified in protocol ?Protocol?
Case 1: ?Method is bound"

+?Method isMethodInClass: ?Class inProtocol: ?Protocol if 
	?Method isMethodWithName: ?Selector inClass: ?Class,?Selector isSelectorOfClass: ?Class inProtocol: ?Protocol.
"Is ?Method of class ?Class classified in protocol ?Protocol?
Case 2: ?Method is bound"

-?Method isMethodInClass: ?Class inProtocol: ?Protocol if 
	?Selector isSelectorOfClass: ?Class inProtocol: ?Protocol,?Method isMethodWithName: ?Selector inClass: ?Class
]

{ #category : #methods }
BasicReasoning >> isMethodInProtocolXM2 [

"Is ?Method classified in protocol ?Protocol?"

?Method isMethodInProtocol: ?Protocol if 
	?Method isMethodInClass: ? inProtocol: ?Protocol
]

{ #category : #naming }
BasicReasoning >> isMethodWithNameXM2 [

"Retrieve the name ?Selector of a method ?Method"

?Method isMethodWithName: ?Selector if 
	?Method isMethod,[MLI current methodNameOf: ?Method] equals: ?Selector
]

{ #category : #naming }
BasicReasoning >> isMethodWithNameXinClassXM3 [

"defines the name (selector) of a method in a class."

?Method isMethodWithName: ?Selector inClass: ?Class if 
	?Method isMethodInClass: ?Class,?Method isMethodWithName: ?Selector
]

{ #category : #methods }
BasicReasoning >> isOverriddenSelectorInClassXM2 [

"Is ?Selector an overridden selector in class ?Class?"

?Selector isOverriddenSelectorInClass: ?Class if 
	?Class classImplementsSelector: ?Selector,?Super isSuperclassOf: ?Class,?Super classUnderstandsSelector: ?Selector
]

{ #category : #naming }
BasicReasoning >> isPackageWithNameXM2 [

"Retrieves the ?Name of a ?Package"

?Package isPackageWithName: ?Name if 
	?Package isPackage,?Name equals: [MLI forSmalltalk nameForPackage: ?Package]
]

{ #category : #methods }
BasicReasoning >> isPrimitiveMethodM1 [

"Is the ?Method a primitive method"

?Method isPrimitiveMethod if 
	?Method isMethod,[?Method isPrimitive]
]

{ #category : #methods }
BasicReasoning >> isSelectorM1 [

"Is ?Selector an existing selector in the system?"

?Selector isSelector if 
	? classImplementsSelector: ?Selector,!
]

{ #category : #methods }
BasicReasoning >> isSelectorOfClassXinProtocolXM3 [

"isSelectorOfClass: verifies whether ?Selector is the name of a
	 method in the protocol with name ?Protocol of class ?Class, or works in a more generative way
	 if one or more of the variables are uninstantiated.

Case 1: ?Selector is unbound"

-?Selector isSelectorOfClass: ?Class inProtocol: ?Protocol if 
	?Protocol isProtocolInClass: ?Class,[MLI current selectorsOfClass: ?Class inProtocol: ?Protocol] contains: ?Selector.
"isSelectorOfClass: verifies whether ?Selector is the name of a
	 method in the protocol with name ?Protocol of class ?Class, or works in a more generative way
	 if one or more of the variables are uninstantiated.

Case 2: ?Selector is bound"

+?Selector isSelectorOfClass: ?Class inProtocol: ?Protocol if 
	?Protocol isProtocolInClass: ?Class,[MLI current isSelector: ?Selector ofClass: ?Class inProtocol: ?Protocol]
]

{ #category : #methods }
BasicReasoning >> isSourceCodeOfMethodXM2 [

"Retrieve the source code of a ?Method"

?Source isSourceCodeOfMethod: ?Method if 
	?Method isMethod,?Source equals: [?Method sourceCode]
]

{ #category : #'method body' }
BasicReasoning >> isStatementOfMethodXM2 [

"Is ?Statement a statement in the method ?Method"

?Statement isStatementOfMethod: ?Method if 
	?Statements areStatementsOfMethod: ?Method,?Statements contains: ?Statement
]

{ #category : #classes }
BasicReasoning >> isSubclassOfXM2 [

"The class ?SubClass is a direct subclass of ?SuperClass"

?SubClass isSubclassOf: ?SuperClass if 
	?SuperClass isSuperclassOf: ?SubClass
]

{ #category : #'method body' }
BasicReasoning >> isTemporaryVariableOfMethodXM2 [

"Retrieve the temporary variables of a ?Method"

?Variable isTemporaryVariableOfMethod: ?Method if 
	RBMethodNode(?,?,?body) isParseTreeOfMethod: ?Method,[?body allTemporaryVariables] contains: ?Variable
]

{ #category : #'method body' }
BasicReasoning >> methodAccessesInstanceVariableXinClassXM3 [

"?Method of ?Class either reads or writes ?Variable
CASE 1: the method assigns"

?Method methodAccessesInstanceVariable: ?Variable inClass: ?class if 
	?Method methodAssignsInstanceVariable: ?Variable inClass: ?class.
"?Method of ?Class either reads or writes ?Variable
CASE 2: the method reads"

?Method methodAccessesInstanceVariable: ?Variable inClass: ?class if 
	?Method methodReadsInstanceVariable: ?Variable inClass: ?class
]

{ #category : #'method body' }
BasicReasoning >> methodAssignsInstanceVariableXinClassXM3 [

"?Does ?Method of ?Class assign to variable ?Variable?"

?Method methodAssignsInstanceVariable: ?Variable inClass: ?Class if 
	?Method isMethodInClass: ?Class,?Method methodAssignsVariable: ?Variable expression: ?,?Variable isInstanceVariableInClassChainOf: ?Class
]

{ #category : #'method body' }
BasicReasoning >> methodAssignsVariableXexpressionXM3 [

"Does the method ?Method contain an assignment to ?Variable  (temp or instance variable) with ?Expression as the rhs argument?"

?Method methodAssignsVariable: ?Variable expression: ?Expression if 
	?Method isMethod,?Tree isParseTreeOfMethod: ?Method,RBAssignmentNode(RBVariableNode(?Variable),?Expression) isStChildOf: ?Tree
]

{ #category : #'method body' }
BasicReasoning >> methodCallsMethodXM2 [

"Does ?Method1 potentially call ?Method2?
This is only a coarse-grained over-estimation: all methods with the correct selector are looked for

Case 1: ?Method2 is not bound; find all methods matching a selector invoked in ?Method1"

?Method1 methodCallsMethod: -?Method2 if 
	?Method1 methodSendsSelector: ?Selector,?Method2 isMethodWithName: ?Selector.
"Does ?Method1 potentially call ?Method2?
This is only a coarse-grained over-estimation: all methods with the correct selector are looked for

Case 2: ?Method2 is bound; Check if ?Method1 calls the selector implemented by ?Method2"

?Method1 methodCallsMethod: +?Method2 if 
	?Method2 isMethodWithName: ?Selector,?Method1 methodSendsSelector: ?Selector
]

{ #category : #methods }
BasicReasoning >> methodOverridesMethodXM2 [

"Does ?Method1 override ?Method2?

Case 1: Both arguments are bound"

+?Method1 methodOverridesMethod: +?Method2 if 
	?Method1 isMethodWithName: ?Selector inClass: ?Class1,?Method2 isMethodWithName: ?Selector inClass: ?Class2,?Class1 isClassBelow: ?Class2.
"Does ?Method1 override ?Method2?

Case 2: ?Method1 is bound; ?Method2 is not bound"

+?Method1 methodOverridesMethod: -?Method2 if 
	?Method1 isMethodWithName: ?Selector inClass: ?Class1,?Class1 isClassBelow: ?Class2,?Method2 isMethodWithName: ?Selector inClass: ?Class2.
"Does ?Method1 override ?Method2?

Case 3: ?Method1 is not bound; ?Method2 is bound"

-?Method1 methodOverridesMethod: +?Method2 if 
	?Method2 isMethodWithName: ?Selector inClass: ?Class2,?Class1 isClassBelow: ?Class2,?Method1 isMethodWithName: ?Selector inClass: ?Class1
]

{ #category : #'method body' }
BasicReasoning >> methodReadsInstanceVariableXinClassXM3 [

"Does ?Method read instance variable ?Variable of class ?Class"

?Method methodReadsInstanceVariable: ?Variable inClass: ?class if 
	?Method isMethodWithName: ?Selector inClass: ?class,?Variable isInstanceVariableInClassChainOf: ?Class,[MLI forSmalltalk
	selectorsOfClass: ?Class
	whichRead: ?Variable asString] contains: ?Selector
]

{ #category : #'method body' }
BasicReasoning >> methodReferencesClassXM2 [

"Does method ?Method refer to class ?Class?"

?Method methodReferencesClass: ?Class if 
	?Method isMethod,[?Method classesReferenced] contains: ?Class
]

{ #category : #'method body' }
BasicReasoning >> methodReturnsBooleanXM2 [

"Does this ?Method return a ?Boolean?"

?Method methodReturnsBoolean: ?Boolean if 
	?Method methodReturnsExpression: RBLiteralValueNode(?Boolean),[?Boolean isKindOf: Boolean]
]

{ #category : #'method body' }
BasicReasoning >> methodReturnsExpressionXM2 [

"Does this ?Method have a return expression ?Expression"

?Method methodReturnsExpression: ?Expression if 
	?Method isMethod,?Tree isParseTreeOfMethod: ?Method,RBReturnNode(?Expression) isStChildOf: ?Tree
]

{ #category : #'method body' }
BasicReasoning >> methodSendsSelectorXM2 [

"Does the ?Method send selector ?Selector?"

?Method methodSendsSelector: ?Selector if 
	?Method isMethod,?tree isParseTreeOfMethod: ?Method,RBMessageNode(?,?Selector,?) isStChildOf: ?tree
]

{ #category : #'method body' }
BasicReasoning >> methodWithUniqueStatementXM2 [

"Does this ?Method have a unique ?Statement?"

?Method methodWithUniqueStatement: ?Statement if 
	<?Statement> areStatementsOfMethod: ?Method
]
