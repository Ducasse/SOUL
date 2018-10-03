Class {
	#name : #MLIForPharo,
	#superclass : #MLIForSmalltalk,
	#category : 'LiCoR-Core'
}

{ #category : #'initialize-release' }
MLIForPharo class >> initialize [ 
	super initialize.
	self setMLI: self new for:#Smalltalk
]

{ #category : #entities }
MLIForPharo >> allBaseClassEntities [
	"Returns a collection containing all the Smalltalk base classes (i.e. classes  
	that are not metaclasses)."

	
	^Smalltalk allClasses
]

{ #category : #'packaging - entities' }
MLIForPharo >> allBundleEntities [
	"Pharo does not have bundles"
	^#()
]

{ #category : #'packaging - entities' }
MLIForPharo >> allCategoryEntities [
	^ Smalltalk organization categories
]

{ #category : #'reification - entities' }
MLIForPharo >> allMethodEntities [
	"Returns a collection containing all the methods in the Smalltalk image. They are wrapped in our own SoulSmalltalkMethod class"

	
	| allMethods filteredMethods |
	allMethods := OrderedCollection new.
	CompiledMethod withAllSubclasses
		do: [:class | allMethods addAll: class allInstances].
	filteredMethods := allMethods
		select: [:m | m methodClass ~~ nil ].
	^filteredMethods
		collect: [:cm | self smalltalkMethodClass compiledMethod: cm]
]

{ #category : #'packaging - entities' }
MLIForPharo >> allNamespaceEntities [
	"Pharo does not have namespaces"
	^#()
]

{ #category : #'packaging - entities' }
MLIForPharo >> allPackageEntities [ 
	"For the time being, have packages and categories coincide in Pharo"
	^self allCategoryEntities 
]

{ #category : #'packaging - entities' }
MLIForPharo >> allParcelEntities [
	"Pharo does not have parcels"
	^#()
]

{ #category : #'method attributes' }
MLIForPharo >> annotationsOfMethod: aMethod [
	| result pragmas |
	result := OrderedCollection new.
	pragmas := aMethod compiledMethod pragmas.
	pragmas do: [:each | result add: each keyword -> each arguments].
	^result
]

{ #category : #'packaging - binary relations' }
MLIForPharo >> categoryForClass: aClass [
	^self packageForClass: aClass
]

{ #category : #naming }
MLIForPharo >> classesFor: aSymbol [
	
	^OrderedCollection with: (Smalltalk classNamed: aSymbol)
]

{ #category : #'packaging - binary relations' }
MLIForPharo >> classesInPackage: aPackage [
	^Smalltalk allClasses select:[:cl | cl category = aPackage]
]

{ #category : #'packaging - binary relations' }
MLIForPharo >> isClass: aClass inPackage: aPackage [
	| package |
	package  := self packageForClass: aClass.
	^package = aPackage
]

{ #category : #'packaging - entities' }
MLIForPharo >> isNameSpace: anObject [
	^false
]

{ #category : #'packaging - entities' }
MLIForPharo >> isPackage: anObject [
	^self allCategoryEntities includes: anObject
]

{ #category : #naming }
MLIForPharo >> nameForPackage: aPackage [
	^aPackage
]

{ #category : #'packaging - binary relations' }
MLIForPharo >> packageForClass: aClass [
	^aClass isMeta 
		ifTrue:[aClass soleInstance category]
		ifFalse:[aClass category]
]

{ #category : #methods }
MLIForPharo >> selectorsOfClass: aClass whichRead: aVariableName [
	| instVarIndex |
	instVarIndex := aClass instVarIndexFor: aVariableName ifAbsent: [^IdentitySet new].
	^ aClass selectors select:  [:sel | 
		((aClass methodDict at: sel)
			readsField: instVarIndex)]
]

{ #category : #private }
MLIForPharo >> smalltalkMethodClass [
	
	^SmalltalkMethodPharo
]
