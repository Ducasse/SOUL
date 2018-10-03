"
PackagingReification reifies the entities that deal with packaging. Essentially this is environment-specific and not language-specific, as there are no real Smalltalk language primitives that deal with packaging.
"
Class {
	#name : #PackagingReification,
	#superclass : #Reification,
	#category : 'LiCoR-Predicates'
}

{ #category : #entities }
PackagingReification >> isClassCategoryM1 [

"Is ?Category a class category
CASE 1: ?Category is not bound"

-?Category isClassCategory if 
	member(?Category,[MLI forSmalltalk allCategoryEntities]).
"Is ?Category a class category
CASE 2: ?Category is  bound"

+?Category isClassCategory if 
	[MLI forSmalltalk isCategory: ?Category]
]

{ #category : #'binary relations' }
PackagingReification >> isClassInCategoryXM2 [

"Belongs ?Class to category ?Category"

?Class isClassInCategory: ?Category if 
	?Class isClass,?Category equals: [MLI forSmalltalk categoryForClass: ?Class]
]

{ #category : #'binary relations' }
PackagingReification >> isClassInPackageXM2 [

"Predicate that verifies whether ?Class belongs to ?Package
Case 1: Both ?Class and ?Package are bound"

+?Class isClassInPackage: +?Package if 
	?Class isClass,?Package isPackage,[MLI forSmalltalk isClass: ?Class inPackage: ?Package].
"Predicate that verifies whether ?Class belongs to ?Package
Case 2:  ?Class is unbound;  ?Package is bound"

-?Class isClassInPackage: +?Package if 
	?Package isPackage,[MLI forSmalltalk classesInPackage: ?Package] contains: ?Class.
"Predicate that verifies whether ?Class belongs to ?Package
Case 3:  ?MetaClass is a meta class (bound);  ?Package is bound"

+?MetaClass isClassInPackage: +?Package if 
	?MetaClass isMetaClass,?Package isPackage,?MetaClass isMetaClassOf: ?Class,[MLI forSmalltalk classesInPackage: ?Package] contains: ?Class.
"Predicate that verifies whether ?Class belongs to ?Package
Case 4:  ?Package is unbound"

?Class isClassInPackage: -?Package if 
	?Class isClass,?Package equals: [MLI forSmalltalk packageForClass: ?Class]
]

{ #category : #'binary relations' }
PackagingReification >> isMethodInPackageXM2 [

"Does ?Method belong to ?Package
Case 1: ?Package is bound"

?Method isMethodInPackage: +?Package if 
	?Package isPackage,[MLI forSmalltalk methodsInPackage: ?Package] contains: ?Method.
"Does ?Method belong to ?Package
Case 2: ?Package is not bound"

?Method isMethodInPackage: -?Package if 
	?Method isMethod,?Package equals: [MLI forSmalltalk packageForMethod: ?Method]
]

{ #category : #entities }
PackagingReification >> isPackageM1 [

"Checks whether ?Package is a package, or retrieves all packages
Case 1: ?Package is bound"

+?Package isPackage if 
	[MLI forSmalltalk isPackage: ?Package].
"Checks whether ?Package is a package, or retrieves all packages
Case 1: ?Package is not bound"

-?Package isPackage if 
	[MLI forSmalltalk allPackageEntities] contains: ?Package
]

{ #category : #'binary relations' }
PackagingReification >> isProtocolInClassXM2 [

"isProtocolInClass/2 implements the 'is in' relation between protocols and classes. You can use it with any of the variables bound or unbound. 	As 	such, you can verify a relation, extract all relations, extract all protocols from a class or find the class in which a protocol is defined

CASE 1: ?Protocol unbound"

-?Protocol isProtocolInClass: ?Class if 
	?Class isClass,[MLI forSmalltalk allProtocolsOfClass: ?Class] contains: ?Protocol.
"isProtocolInClass/2 implements the 'is in' relation between protocols and classes. You can use it with any of the variables bound or unbound. 	As 	such, you can verify a relation, extract all relations, extract all protocols from a class or find the class in which a protocol is defined

CASE 2: ?Protocol bound"

+?Protocol isProtocolInClass: ?Class if 
	?Class isClass,[MLI forSmalltalk isProtocol: ?Protocol ofClass: ?Class]
]

{ #category : #entities }
PackagingReification >> isProtocolM1 [

"Is ?Protocol a method protocol?"

?Protocol isProtocol if 
	member(?Protocol,[MLI forSmalltalk allProtocolEntities])
]
