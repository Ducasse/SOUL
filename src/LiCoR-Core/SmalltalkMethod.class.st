"
Encapsulates compiledMethods as logic terms to be used in the LiCoR rules. We have two reasons for implementing this special term to represent methods inside LiCoR:

* optimization: Using compiledmethods instead of source or parsetrees allows us to extract some information at high speeds (such as abstract, messages send, etc....)
* if the actual method changes in the image, our term automatically *will* be updated with the new compiledmethod

"
Class {
	#name : #SmalltalkMethod,
	#superclass : #Object,
	#instVars : [
		'parsetree',
		'compiledMethod',
		'selector',
		'test'
	],
	#category : 'LiCoR-Core'
}

{ #category : #'instance creation' }
SmalltalkMethod class >> class: aClass selector: aSelector [
	
	^self compiledMethod: (aClass compiledMethodAt: aSelector)
]

{ #category : #'instance creation' }
SmalltalkMethod class >> compiledMethod: aCompiledMethod [
	
	^self new compiledMethod: aCompiledMethod
]

{ #category : #comparing }
SmalltalkMethod >> = anObject [
	
	^(anObject isKindOf: self class)
		ifTrue:
			[(anObject selector = self selector & anObject fromClass) = self fromClass]
		ifFalse: [false]
]

{ #category : #'information extraction' }
SmalltalkMethod >> allSourceComments [
	"TODO: Is this the best place to deal with non-regular methods such as the methods on LogicStorage? Furthermore, is the best way to deal with them just catching any exceptions in the parsing of the method source?"

	^ [ 
		CommentCollectorVisitor new
			visitNode: (RBParser parseMethod: self sourceCode);
			allCollectedComments
		]
			on: Exception
			do: [ :exception | OrderedCollection new ]
]

{ #category : #'information extraction' }
SmalltalkMethod >> attributeMessages [
	
	^OrderedCollection new
]

{ #category : #'information extraction' }
SmalltalkMethod >> attributes [
	
	^OrderedCollection new
]

{ #category : #'information extraction' }
SmalltalkMethod >> classesReferenced [
	
	self subclassResponsibility
]

{ #category : #private }
SmalltalkMethod >> compiledMethod [
	
	^compiledMethod
]

{ #category : #initialize }
SmalltalkMethod >> compiledMethod: aCompiledMethod [
	
	compiledMethod := aCompiledMethod.
	selector := nil
]

{ #category : #'information extraction' }
SmalltalkMethod >> fromClass [
	
	self subclassResponsibility
]

{ #category : #comparing }
SmalltalkMethod >> hash [
	
	^self compiledMethod hash
]

{ #category : #'information extraction' }
SmalltalkMethod >> isAbstract [
	
	self subclassResponsibility
]

{ #category : #'information extraction' }
SmalltalkMethod >> isCancelled [
	
	self subclassResponsibility
]

{ #category : #'information extraction' }
SmalltalkMethod >> isPrimitive [
	
	^compiledMethod primitiveNumber isNil not
]

{ #category : #'information extraction' }
SmalltalkMethod >> messages [
	
	^compiledMethod messages
]

{ #category : #printing }
SmalltalkMethod >> printOn: aStream [
	
	aStream write: self fromClass asString , '>>' , self selector
]

{ #category : #'information extraction' }
SmalltalkMethod >> rbParseTree [
	
	| myClass |
	myClass := self fromClass.
	parsetree == nil
		ifTrue:
			[parsetree := myClass compilerClass = Object compilerClass
				ifTrue:
					[RBParser
						parseMethod: self sourceCode
						onError: [:mesg :pos | ^nil]]
				ifFalse:
					["Soul.SmalltalkParseTreeConverter new doString: self selector inClass: myClass"

					^nil]].
	parsetree method: self.
	^parsetree
]

{ #category : #'information extraction' }
SmalltalkMethod >> referencesClass: aClass [
	
	self subclassResponsibility
]

{ #category : #'information extraction' }
SmalltalkMethod >> selector [
	
	selector isNil ifTrue: [selector := compiledMethod selector].
	^selector
]

{ #category : #'information extraction' }
SmalltalkMethod >> sendsSelector: aSelector [
	
	^compiledMethod sendsSelector: aSelector
]

{ #category : #'information extraction' }
SmalltalkMethod >> sourceCode [
	| source |
	source := compiledMethod sourceCode.
	source ifNil: [ source := compiledMethod decompiledSource ].
	^ source
]
