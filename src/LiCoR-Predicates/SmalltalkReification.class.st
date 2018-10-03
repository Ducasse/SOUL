"
SmalltalkReification reifies the real Smalltalk lanuage entities. Is not supposed to contain any environment-specific stuff.
"
Class {
	#name : #SmalltalkReification,
	#superclass : #Reification,
	#category : 'LiCoR-Predicates'
}

{ #category : #entities }
SmalltalkReification >> isBaseClassM1 [

"This predicate verifies whether ?Class is a base class

CASE 1: the variable ?Class is bound"

+?class isBaseClass if 
	[MLI forSmalltalk isBaseClass: ?class].
"This predicate verifies whether ?Class is a base class 

CASE 2: the variable ?Class is not bound"

-?Class isBaseClass if 
	[MLI forSmalltalk allBaseClassEntities] contains: ?Class
]

{ #category : #entities }
SmalltalkReification >> isClassM1 [

"This predicate verifies whether ?Class is a base or meta class

CASE 1: the variable ?Class is bound"

+?Class isClass if 
	[MLI forSmalltalk isClass: ?Class].
"This predicate verifies whether ?Class is a base or meta class

CASE 2: the variable ?Class is not bound"

-?Class isClass if 
	[MLI forSmalltalk allClassEntities] contains: ?Class
]

{ #category : #'binary relations' }
SmalltalkReification >> isClassMethodInClassXM2 [

"?Method isClassMethodInClass: ?Class verifies whether a ?Class contains
	 a given class ?Method or returns the appropriate value if one (or more) of the arguments
	 is variable.

CASE 1: ?Method is known"

+?Method isClassMethodInClass: ?Class if 
	?Class isClass,[MLI forSmalltalk isClassMethod: ?Method inClass: ?Class].
"CASE 2: ?Method is unknown"

-?Method isClassMethodInClass: ?Class if 
	?Class isClass,[MLI forSmalltalk classMethodsInClass: ?Class] contains: ?Method
]

{ #category : #'binary relations' }
SmalltalkReification >> isClassVariableInClassXM2 [

"?ClassVariable isClassVariableInClass: ?Class verifies whether a ?Class contains
	 a given ?ClassVariable or returns the appropriate values if one (or more) of the arguments
	 is variable.

CASE 1: +?ClassVariable isClassVariableInClass: ?Class"

+?ClassVariable isClassVariableInClass: ?Class if 
	?Class isClass,[MLI forSmalltalk isClassVariable: ?ClassVariable inClass: ?Class].
"CASE 2: -?ClassVariable isClassVariableInClass: ?Class"

-?ClassVariable isClassVariableInClass: ?Class if 
	?Class isClass,[MLI forSmalltalk allClassVariableEntitiesInClass: ?Class] contains: ?ClassVariable
]

{ #category : #entities }
SmalltalkReification >> isClassVariableM1 [

"+?ClassVar isClassVariableverifies whether ?ClassVar is a class variable of some existing class
	 or returns the appropriate value if ?ClassVar is variable.

CASE 1:+?ClassVar isClassVariable checks whether ?ClassVar is an existing class variable"

+?ClassVar isClassVariable if 
	[MLI forSmalltalk isClassVariable: ?ClassVar].
"CASE 2: -?ClassVar isClassVariable returns an existing class variable"

-?ClassVar isClassVariable if 
	[MLI forSmalltalk allClassVariableEntities] contains: ?ClassVar
]

{ #category : #'binary relations' }
SmalltalkReification >> isInstanceVariableInClassChainOfXM2 [

"?InstanceVariable isInstanceVariableInClassChainOf: ?Class verifies whether a ?Class or
	 one of its (direct or indirect) superclasses declares a given ?InstanceVariable. If ?Class is
	 variable, the class that declares the ?InstanceVariable as well as all of its subclasses are
	 returned. If ?InstanceVariable is variable, all instance variables that are declared in ?Class
	 or one of its superclasses are returned. If both are variable we have the combination of
	 these two situations and we produce all appropriate solutions.

CASE 1: +?InstanceVariable isInstanceVariableInClassChainOf: ?Class"

+?InstanceVariable isInstanceVariableInClassChainOf: ?Class if 
	?Class isClass,[MLI forSmalltalk isInstanceVariable: ?InstanceVariable inClassChain: ?Class].
"CASE 2: -?InstanceVariable isInstanceVariableInClassChainOf: ?Class"

-?InstanceVariable isInstanceVariableInClassChainOf: ?Class if 
	?Class isClass,[MLI forSmalltalk allInstanceVariableEntitiesInClassChain: ?Class] contains: ?InstanceVariable
]

{ #category : #'binary relations' }
SmalltalkReification >> isInstanceVariableInClassXM2 [

"+?InstanceVariable isInstanceVariableInClass: ?Class verifies whether a ?Class contains
	 a given ?InstanceVariable or returns the appropriate values if one (or more) of the arguments
	 is variable.

CASE 1: +?InstanceVariable isInstanceVariableInClass: +-?Class"

+?InstanceVariable isInstanceVariableInClass: ?Class if 
	?Class isClass,[MLI forSmalltalk isInstanceVariable: ?InstanceVariable inClass: ?Class].
"CASE 2: -?InstanceVariable isInstanceVariableInClass: +-?Class"

-?InstanceVariable isInstanceVariableInClass: ?Class if 
	?Class isClass,[MLI forSmalltalk allInstanceVariableEntitiesInClass: ?Class] contains: ?InstanceVariable
]

{ #category : #'binary relations' }
SmalltalkReification >> isInstanceVariableInMetaClassChainOfXM2 [

"?InstanceVariable isInstanceVariableInMetaClassChainOf: ?Class verifies whether a ?Class or
	 one of its (direct or indirect) superclasses declares a given ?InstanceVariable. If ?Class is
	 variable, the class that declares the ?InstanceVariable as well as all of its subclasses are
	 returned. If ?InstanceVariable is variable, all instance variables that are declared in ?Class
	 or one of its superclasses are returned. If both are variable we have the combination of
	 these two situations and we produce all appropriate solutions."

?InstanceVariable isInstanceVariableInMetaClassChainOf: ?Class if 
	?Class isMetaClass,?InstanceVariable isInstanceVariableInClassChainOf: ?Class
]

{ #category : #'binary relations' }
SmalltalkReification >> isInstanceVariableInMetaClassXM2 [

"?InstanceVariable isInstanceVariableInMetaClass: ?Class verifies whether a metaclass ?Class contains
	 a given ?InstanceVariable or returns the appropriate values if one (or more) of the arguments
	 is variable."

?InstanceVariable isInstanceVariableInMetaClass: ?Class if 
	?Class isMetaClass,?InstanceVariable isInstanceVariableInClass: ?Class
]

{ #category : #entities }
SmalltalkReification >> isInstanceVariableM1 [

"+?InstVar isInstanceVariable verifies whether ?InstVar is an instance variable of some existing Smalltalk class
	 or returns the appropriate value if ?InstVar is variable.

CASE 1: +?InstVar isInstanceVariable checks whether ?InstVar is an existing instance variable"

+?InstVar isInstanceVariable if 
	[MLI forSmalltalk isInstanceVariable: ?InstVar].
"CASE 2: -?InstVar isInstanceVariable returns an existing instance variable"

-?InstVar isInstanceVariable if 
	[MLI forSmalltalk allInstanceVariableEntities] contains: ?InstVar
]

{ #category : #entities }
SmalltalkReification >> isMetaClassM1 [

"This predicate verifies whether ?Class is a meta class

CASE 1: the variable ?Class is bound"

+?Class isMetaClass if 
	[MLI forSmalltalk isMetaClass: ?Class].
"This predicate verifies whether ?Class is a meta class

CASE 2: the variable ?Class is not bound"

-?Class isMetaClass if 
	[MLI forSmalltalk allMetaClassEntities] contains: ?Class
]

{ #category : #'binary relations' }
SmalltalkReification >> isMetaClassOfXM2 [

"?MetaClass isMetaClassOf: ?Class verifies whether ?MetaClass is the Smalltalk metaclass
	 of ?Class. It works for ?MetaClass and ?Class bound or variable"

?MetaClass isMetaClassOf: ?Class if 
	?Class isClass,?MetaClass equals: [MLI forSmalltalk metaClassOf: ?Class]
]

{ #category : #'binary relations' }
SmalltalkReification >> isMethodInClassXM2 [

"+?Method isMethodInClass: ?Class  verifies whether a ?Class contains
	 a given ?Method or returns the appropriate value if one (or more) of the arguments
	 is variable.

CASE 1: ?Method is known. Assumption: a method is in ONE class."

+?Method isMethodInClass: ?Class if 
	?Method isMethod,?Class equals: [MLI forSmalltalk classOfMethod: ?Method].
"CASE 2: ?Method is unknown"

-?Method isMethodInClass: ?Class if 
	?Class isClass,[MLI forSmalltalk methodsInClass: ?Class] contains: ?Method
]

{ #category : #entities }
SmalltalkReification >> isMethodM1 [

"+-?Method isMethod  verifies whether ?Method is a Smalltalk method. If ?Method is a variable
	 it will be instantiated with a method. If ?Method is bound it should be an
	 existing method in the current Smalltalk image.

CASE 1: +Method isMethod checks whether ?method is an existing method"

+?Method isMethod if 
	[MLI forSmalltalk isMethod: ?Method].
"CASE 2: -Method isMethod returns an existing method"

-?Method isMethod if 
	[MLI forSmalltalk allMethodEntities] contains: ?Method
]

{ #category : #'method attributes' }
SmalltalkReification >> isParseTreeOfMethodXM2 [

?tree isParseTreeOfMethod: ?method if 
	?method isMethod, ?tree equals: [?method rbParseTree],[?tree notNil]
]

{ #category : #entities }
SmalltalkReification >> isRootClassM1 [

"isRootClass verifies whether ?Class is a root class, i.e., whether it has
	 no superclass. If ?Class is variable it will be instantiated with such a class.
	 If ?Class is bound it should be an existing root class in the current system.

CASE 1: rootClass(+?Class) checks whether ?Class is an existing root class"

+?Class isRootClass if 
	[MLI forSmalltalk isRootClass: ?Class].
"CASE 2: isRootClass returns an existing root class"

-?Class isRootClass if 
	[MLI forSmalltalk allRootClassEntities] contains: ?Class
]

{ #category : #'method attributes' }
SmalltalkReification >> isSourceCodeOfMethodXM2 [

"Retrieve the ?Source of a ?Method"

?Source isSourceCodeOfMethod: ?Method if 
	?Method isMethod,?Source equals: [?Method sourceCode]
]

{ #category : #'parsetree traversal' }
SmalltalkReification >> isStChildOfXM2 [

?aTerm isStChildOf: ?aTerm if 
	not([?aTerm isKindOf: OrderedCollection]).
?aTerm isStChildOf: ?afunctor@(?args) if 
	?args contains: ?child,?aTerm isStChildOf: ?child
]

{ #category : #'binary relations' }
SmalltalkReification >> isSuperclassOfXM2 [

"?SuperClass isSuperclassOf: ?SubClass verifies whether ?SuperClass is a super class of
	 ?SubClass in the Smalltalk class hierachy. If one (or both) arguments are unbound,
	 the appropriate values will be produced for them.

Implementation note: In the implementation below some of the cases could have been
	 taken together in a single case, but for performance reasons we preferred to handle all
	 cases separately. This is a frequently used predicate that should be implemented as
	 efficient as possible.

CASE 1: +?SuperClass isSuperclassOf: +?SubClass"

+?SuperClass isSuperclassOf: +?SubClass if 
	?SuperClass isClass,?SubClass isClass,[MLI forSmalltalk is: ?SuperClass superclassOf: ?SubClass].
"CASE 2: -?SuperClass isSuperclassOf: +?SubClass"

-?SuperClass isSuperclassOf: +?SubClass if 
	?SubClass isClass,?SuperClass equals: [MLI forSmalltalk hasSuperclass: ?SubClass],[?SuperClass isNil not].
"CASE 3 & 4: +-?SuperClass isSuperclassOf: -?SubClass

?SuperClass may be either variable or not but it must be a class"

?SuperClass isSuperclassOf: -?SubClass if 
	?SuperClass isClass,[MLI forSmalltalk subclassesOf: ?SuperClass] contains: ?SubClass
]

{ #category : #'method attributes' }
SmalltalkReification >> methodContainsSourceCommentXM2 [

"Is ?Comment a comment in the source code of method ?Method"

?Method methodContainsSourceComment: ?Comment if 
	?Method isMethod,[MLI forSmalltalk sourceCommentsForMethod: ?Method] contains: ?Comment
]

{ #category : #'method attributes' }
SmalltalkReification >> methodHasAnnotationXwithValuesXM3 [

"This predicate retrieves all ?Annotations of a ?Method, together with the list of ?Values of that annotation"

?Method methodHasAnnotation: ?Annotation withValues: ?Values if 
	?Method isMethod,[MLI forSmalltalk annotationsOfMethod: ?Method] contains: ?association,?Annotation equals: [?association key],?Values equals: [?association value]
]
