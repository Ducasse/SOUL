Class {
	#name : #MLIForSmalltalk,
	#superclass : #MLI,
	#category : 'LiCoR-Core'
}

{ #category : #'reification - entities' }
MLIForSmalltalk >> allBaseClassEntities [
	
	self subclassResponsibility
]

{ #category : #'packaging - entities' }
MLIForSmalltalk >> allBundleEntities [
	
	self subclassResponsibility
]

{ #category : #'packaging - entities' }
MLIForSmalltalk >> allCategoryEntities [
	
	self subclassResponsibility
]

{ #category : #'reification - entities' }
MLIForSmalltalk >> allClassEntities [
	"Returns a collection containing all the Smalltalk classes and metaclasses."

	
	^(self allMetaClassEntities)
		addAll: self allBaseClassEntities;
		yourself
]

{ #category : #private }
MLIForSmalltalk >> allClassEntitiesAsNamespaceEntities [
	
	^self allClassEntities collect: [:class | class asNameSpace]
]

{ #category : #'reification - entities' }
MLIForSmalltalk >> allClassVariableEntities [
	"Returns all existing class variables."

	"We use a Set in the implementation below to avoid producing duplicates in the result."

	
	^self allMetaClassEntities
		inject: Set new
		into:
			[:sub :el | 
			(self allInstanceVariableEntitiesInClass: el)
				addAll: sub;
				yourself]
]

{ #category : #'reification - binary relations' }
MLIForSmalltalk >> allClassVariableEntitiesInClass: aClass [
	"Returns a collection containg all the class variables of class aClass."

	
	^(aClass class instVarNames collect: [:each | each asSymbol])
		asOrderedCollection
]

{ #category : #'packaging - binary relations' }
MLIForSmalltalk >> allClassesInNamespace: aNameSpace [
	"has to return a collection containing all the classes belonging to aNamespace or one of its subnamespaces"

	
	^self subclassResponsibility
]

{ #category : #'reification - entities' }
MLIForSmalltalk >> allInstanceVariableEntities [
	"Returns all existing instance variables."

	"We use a Set in the implementation below to avoid producing duplicates in the result."

	
	^self allBaseClassEntities
		inject: Set new
		into:
			[:sub :el | 
			(self allInstanceVariableEntitiesInClass: el)
				addAll: sub;
				yourself]
]

{ #category : #'reification - binary relations' }
MLIForSmalltalk >> allInstanceVariableEntitiesInClass: aClass [
	"Returns a collection containg all the instance variables of class aClass."

	
	^(aClass instVarNames collect: [:each | each asSymbol])
		asOrderedCollection
]

{ #category : #'reification - binary relations' }
MLIForSmalltalk >> allInstanceVariableEntitiesInClassChain: aClass [
	"Returns a collection containing all the instance variables declared
	 somewhere in the class chain of aClass (i.e. in aClass itself or in
	 one of its superclassses."

	
	^(aClass allInstVarNames collect: [:each | each asSymbol])
		asOrderedCollection
]

{ #category : #'reification - entities' }
MLIForSmalltalk >> allMetaClassEntities [
	"Returns a collection containing all the Smalltalk meta classes."

	
	^self allBaseClassEntities collect: [:aClass | aClass class]
]

{ #category : #'reification - entities' }
MLIForSmalltalk >> allMethodEntities [
	self subclassResponsibility 
]

{ #category : #'packaging - entities' }
MLIForSmalltalk >> allNamespaceEntities [
	
	self subclassResponsibility
]

{ #category : #'packaging - entities' }
MLIForSmalltalk >> allPackageEntities [
	
	self subclassResponsibility
]

{ #category : #'packaging - entities' }
MLIForSmalltalk >> allParcelEntities [
	
	self subclassResponsibility
]

{ #category : #'packaging - entities' }
MLIForSmalltalk >> allProtocolEntities [
	
	| prots |
	prots := Set new.
	self allClassEntities
		do: [:aClass | prots addAll: (self allProtocolsOfClass: aClass)].
	^prots
]

{ #category : #'packaging - binary relations' }
MLIForSmalltalk >> allProtocolsOfClass: aClass [
	"Returns a collection containing all the protocols of the argument, aClass"

	
	^aClass organization categories
]

{ #category : #'reification - entities' }
MLIForSmalltalk >> allRootClassEntities [
	"Returns all the root classes (= classes that have no superclasses) in the current image."

	
	^self allBaseClassEntities select: [:cl | self isRootClass: cl]
]

{ #category : #classes }
MLIForSmalltalk >> allSelectorsUnderstoodByClass: aClass [
	
	^aClass allSelectors
]

{ #category : #'reification - entities' }
MLIForSmalltalk >> allSharedVariableEntities [
	"Returns all existing shared variables."

	
	^(self allNamespaceEntities
		addAll: self allClassEntitiesAsNamespaceEntities)
		inject: Set new
		into:
			[:sub :el | 
			(self allSharedVariableEntitiesInNamespace: el)
				addAll: sub;
				yourself]
]

{ #category : #'reification - binary relations' }
MLIForSmalltalk >> allSharedVariableEntitiesInClass: aClass [
	"Returns a collection containg all the instance variables of class aClass."

	
	^aClass asNameSpace localBindings asOrderedCollection
]

{ #category : #'packaging - binary relations' }
MLIForSmalltalk >> allSharedVariableEntitiesInNamespace: aNamespace [
	
	self subclassResponsibility
]

{ #category : #classes }
MLIForSmalltalk >> allSubclassesOf: aClass [
	"return a stream with all subclasses for aClass (direct AND indirect  
	subclasses)"

	
	^aClass withAllSubclasses asOrderedCollection
]

{ #category : #classes }
MLIForSmalltalk >> allSuperclassesOf: aClass [
	"return a stream with all superclasses for aClass (all the way up until  
	the rootclass)"

	
	^aClass withAllSuperclasses
]

{ #category : #'method attributes' }
MLIForSmalltalk >> annotationsOfMethod: aMethod [
	
	self subclassResponsibility
]

{ #category : #'packaging - binary relations' }
MLIForSmalltalk >> bundlesForPackage: aPackage [
	
	self subclassResponsibility
]

{ #category : #'packaging - binary relations' }
MLIForSmalltalk >> categoryForClass: aClass [
	
	self subclassResponsibility
]

{ #category : #classes }
MLIForSmalltalk >> class: class understands: selector [
	
	^class allSelectors includes: selector
]

{ #category : #'reification - binary relations' }
MLIForSmalltalk >> classMethodsInClass: aClass [
	
	| aClassClass |
	aClassClass := aClass class.
	^aClassClass selectors
		collect:
			[:sel | self smalltalkMethodClass class: aClassClass selector: sel]
]

{ #category : #naming }
MLIForSmalltalk >> classNameOf: aClass [
	"Returns a symbol representing the name of aClass"

	
	^aClass name asSymbol
]

{ #category : #'reification - binary relations' }
MLIForSmalltalk >> classOfMethod: aMethod [
	"Informs the class of a method."

	
	^aMethod fromClass
]

{ #category : #naming }
MLIForSmalltalk >> classVariableNameOf: aClassVariable [
	"Returns a symbol representing the name of aClassVariable"

	
	^aClassVariable asSymbol
]

{ #category : #naming }
MLIForSmalltalk >> classesFor: aName [
	
	self subclassResponsibility
]

{ #category : #'packaging - binary relations' }
MLIForSmalltalk >> classesInBundle: aBundle [
	
	self subclassResponsibility
]

{ #category : #'packaging - binary relations' }
MLIForSmalltalk >> classesInPackage: aPackage [
	
	self subclassResponsibility
]

{ #category : #'packaging - binary relations' }
MLIForSmalltalk >> classesInParcel: aParcel [
	
	self subclassResponsibility
]

{ #category : #'packaging - binary relations' }
MLIForSmalltalk >> extensionMethodsInParcel: aParcel [
	
	self subclassResponsibility
]

{ #category : #'reification - binary relations' }
MLIForSmalltalk >> hasSuperclass: aClass [
	"returns the superclass of a class"

	
	^aClass superclass
]

{ #category : #naming }
MLIForSmalltalk >> instanceVariableNameOf: anInstanceVariable [
	"Returns a symbol representing the name of anInstanceVariable"

	
	^anInstanceVariable asSymbol
]

{ #category : #classes }
MLIForSmalltalk >> is: subClass below: rootClass [
	"returns true if subClass belongs to the hierarchy of rootClass (directly 
	or indirectly)"

	
	^rootClass withAllSubclasses includes: subClass
]

{ #category : #'reification - binary relations' }
MLIForSmalltalk >> is: class1 superclassOf: class2 [
	"Returns true if class1 is superclass of class2. returns false otherwise."

	
	^class2 superclass = class1
]

{ #category : #'reification - entities' }
MLIForSmalltalk >> isBaseClass: arg [
	"has to return true if the argument arg is a base class, false otherwise"

	
	^(self isMetaClass: arg) not and: [self isClass: arg]
]

{ #category : #'packaging - entities' }
MLIForSmalltalk >> isCategory: aCategory [
	
	^self allCategoryEntities includes: aCategory
]

{ #category : #'reification - entities' }
MLIForSmalltalk >> isClass: arg [
	"returns true if the argument arg is a Smalltalk class or metaclass, false otherwise"

	
	^arg respondsTo: #basicNew
]

{ #category : #'packaging - binary relations' }
MLIForSmalltalk >> isClass: aClass inPackage: aPackage [
	
	self subclassResponsibility
]

{ #category : #'reification - binary relations' }
MLIForSmalltalk >> isClassMethod: aMethod inClass: aClass [
	"Returns true if aMethod is a CLASS method of class aClass. Return false otherwise."

	
	^(self isMethod: aMethod) and: [aClass class == aMethod fromClass]
]

{ #category : #'reification - entities' }
MLIForSmalltalk >> isClassVariable: aVar [
	"Returns true if aVar is an class variable of some class."

	
	^(self allBaseClassEntities
		detect: [:class | self isClassVariable: aVar inClass: class]
		ifNone: [nil]) isNil not
]

{ #category : #'reification - binary relations' }
MLIForSmalltalk >> isClassVariable: aVar inClass: aClass [
	"returns true if aVar is a class variable of class aClass. Return false 
	otherwise "

	
	^self
		isInstanceVariable: aVar
		inClass: aClass class
]

{ #category : #'reification - entities' }
MLIForSmalltalk >> isInstanceVariable: aVar [
	"Returns true if aVar is an instance variable of some class."

	
	^(self allBaseClassEntities
		detect: [:class | self isInstanceVariable: aVar inClass: class]
		ifNone: [nil]) isNil not
]

{ #category : #'reification - binary relations' }
MLIForSmalltalk >> isInstanceVariable: aVar inClass: aClass [
	"Returns true if aVar is an instance variable of class aClass. Return 
	false otherwise."

	
	^(self allInstanceVariableEntitiesInClass: aClass) includes: aVar
]

{ #category : #'reification - binary relations' }
MLIForSmalltalk >> isInstanceVariable: aVar inClassChain: aClass [
	"Returns true if aVar is an instance variable declared in the class chain of aClass
	 (i.e. in aClass or one of its superclasses). Return false otherwise."

	
	^aClass allInstVarNames includes: aVar asString
]

{ #category : #'reification - entities' }
MLIForSmalltalk >> isMetaClass: arg [
	"has to return true if the argument arg is a meta class, false otherwise"

	
	^arg class == Metaclass
]

{ #category : #'reification - entities' }
MLIForSmalltalk >> isMethod: aMethod [
	"Checks if aMethod is a Smalltalk method. This means that it must be a SmalltalkMethod object"

	
	^aMethod isKindOf: SmalltalkMethod
]

{ #category : #'packaging - entities' }
MLIForSmalltalk >> isNameSpace: anObject [
	
	self subclassResponsibility
]

{ #category : #'packaging - entities' }
MLIForSmalltalk >> isPackage: anObject [
	
	self subclassResponsibility
]

{ #category : #'packaging - binary relations' }
MLIForSmalltalk >> isProtocol: aProtocolName ofClass: aClass [
	"Checks whether aProtocolName is the name of a protocol in the class 
	aClass "

	
	^aClass organization categories includes: aProtocolName
]

{ #category : #'reification - entities' }
MLIForSmalltalk >> isRootClass: aClass [
	"Returns a Boolean indicating whether aClass has no superclass."

	
	^aClass superclass isNil
]

{ #category : #methods }
MLIForSmalltalk >> isSelector: aSelector ofClass: aClass inProtocol: aProtocolName [
	"checks whether aSelector is the name of a method in the protocol with 
	name aProtocolName of the class aClass"

	
	^(aClass organization listAtCategoryNamed: aProtocolName) includes:
			aSelector
]

{ #category : #'reification - entities' }
MLIForSmalltalk >> isSharedVariable: aVar [
	"Returns true if aVar is a shared variable"

	
	^((self allNamespaceEntities
		addAll: self allClassEntitiesAsNamespaceEntities)
		detect: [:ns | self isSharedVariable: aVar inNamespace: ns]
		ifNone: [nil]) isNil not
]

{ #category : #'reification - binary relations' }
MLIForSmalltalk >> isSharedVariable: aVar inClass: aClass [
	"Returns true if aVar is a shared variable of class aClass. Return 
	false otherwise."

	
	^self
		isSharedVariable: aVar
		inNamespace: aClass asNameSpace
]

{ #category : #'packaging - binary relations' }
MLIForSmalltalk >> isSharedVariable: aVar inNamespace: aNamespace [
	
	self subclassResponsibility
]

{ #category : #'reification - binary relations' }
MLIForSmalltalk >> metaClassOf: aClass [
	"returns the meta class of aClass"

	
	^aClass class
]

{ #category : #naming }
MLIForSmalltalk >> methodNameOf: aMethod [
	"Returns a symbol representing the name of aMethod"

	
	^aMethod selector asSymbol
]

{ #category : #'reification - binary relations' }
MLIForSmalltalk >> methodsInClass: aClass [
	
	^aClass selectors
		collect: [:sel | self smalltalkMethodClass class: aClass selector: sel]
]

{ #category : #'packaging - binary relations' }
MLIForSmalltalk >> methodsInPackage: aPackage [
	
	self subclassResponsibility
]

{ #category : #naming }
MLIForSmalltalk >> nameForBundle: aBundle [
	
	self subclassResponsibility
]

{ #category : #naming }
MLIForSmalltalk >> nameForPackage: aPackage [
	
	self subclassResponsibility
]

{ #category : #naming }
MLIForSmalltalk >> nameForParcel: aParcel [
	
	self subclassResponsibility
]

{ #category : #'packaging - binary relations' }
MLIForSmalltalk >> namespaceForClass: aClass [
	"has to return the namespace for aClass"

	
	^self subclassResponsibility
]

{ #category : #naming }
MLIForSmalltalk >> namespaceNameOf: aNamespace [
	
	self subclassResponsibility
]

{ #category : #'packaging - binary relations' }
MLIForSmalltalk >> namespacesInPackage: aPackage [
	
	self subclassResponsibility
]

{ #category : #'packaging - binary relations' }
MLIForSmalltalk >> packageForClass: aClass [
	
	self subclassResponsibility
]

{ #category : #'packaging - binary relations' }
MLIForSmalltalk >> packageForMethod: aMethod [
	
	self subclassResponsibility
]

{ #category : #'packaging - binary relations' }
MLIForSmalltalk >> packageForNamespace: aNamespace [
	
	self subclassResponsibility
]

{ #category : #'packaging - binary relations' }
MLIForSmalltalk >> packagesInBundle: aBundle [
	
	self subclassResponsibility
]

{ #category : #'packaging - binary relations' }
MLIForSmalltalk >> parcelForClass: aClass [
	
	self subclassResponsibility
]

{ #category : #methods }
MLIForSmalltalk >> selectorsOfClass: aClass inProtocol: aProtocolName [
	"computes the list of all selectors in the protocol with name  
	aProtocolName of class aClass"

	
	^aClass organization listAtCategoryNamed: aProtocolName
]

{ #category : #methods }
MLIForSmalltalk >> selectorsOfClass: aClass whichRead: aName [
	self subclassResponsibility 
]

{ #category : #private }
MLIForSmalltalk >> smalltalkMethodClass [
	
	self subclassResponsibility
]

{ #category : #'method attributes' }
MLIForSmalltalk >> sourceCommentsForMethod: aMethod [
	
	^aMethod allSourceComments
]

{ #category : #'reification - binary relations' }
MLIForSmalltalk >> subclassesOf: aClassOrNil [
	"returns a stream containing the subclasses for the  
	argument, aClassOrNil.  
	aClassOrNil can be nil, so take care"

	
	^aClassOrNil isNil
		ifTrue: [Class rootsOfTheWorld]
		ifFalse: [aClassOrNil subclasses asArray]
]
