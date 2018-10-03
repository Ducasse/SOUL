Class {
	#name : #TestClassRoot,
	#superclass : #Object,
	#category : 'LiCoR-Tests'
}

{ #category : #testing }
TestClassRoot class >> aClassMethod [
	
	^self new
]

{ #category : #traversal }
TestClassRoot >> complexWith: modifiers and: bindings and: specificImports and: generalImports [
	
	| key bind aName |
	aName := 'dummy' , 'concatenation' , $a printString.
	(modifiers hasVisited: self) ifTrue: [^nil].
	key := self asKey: aName.
	bind := bindings lookup: key.
	bind == nil ifFalse: [^bind].
	bind := modifiers substituteFor: self localBindingFor: key.
	bind == nil ifFalse: [^bind].
	1
		to: specificImports size
		do:
			[:imp | 
			bind := (specificImports at: imp) bindingFor: key modifiers: modifiers.
			bind == nil ifFalse: [^bind]].
	bind := nil.
	generalImports size > 0
		ifTrue:
			[modifiers
				forNames: self
				do:
					[1
						to: generalImports size
						do:
							[:imp | 
							| b |
							b := (generalImports at: imp) bindingFor: key modifiers: modifiers.
							b == nil
								ifFalse:
									[(bind == nil or: [bind == b])
										ifTrue: [bind := b]
										ifFalse: [bind := self conflictingImports: key firstFound: bind]]]]].
	^bind
]

{ #category : #testing }
TestClassRoot >> doNotOverride [
	
	self subclassResponsibility
]

{ #category : #traversal }
TestClassRoot >> foo [
	
	| newString |
	1
		to: 10
		do: [:each | each halt].
	^self
		compile: (newString := self copy);
		zork
]

{ #category : #traversal }
TestClassRoot >> methodWithAssignment [
	
	| temp |
	temp := 1
]

{ #category : #traversal }
TestClassRoot >> methodWithSend [
	
	self methodWithAssignment first
]

{ #category : #traversal }
TestClassRoot >> methodWithSimpleReturn [
	
	^1
]

{ #category : #traversal }
TestClassRoot >> otherComplexWith: aString [
	
	| compiler method mclass env newString |
	compiler := self compilerClass new.
	self namedReferent isBehavior
		ifTrue:
			[mclass := self namedReferent.
			env := mclass environment]
		ifFalse:
			[mclass := nil class.
			env := self namedReferent].
	method := compiler
		methodClass: compiler methodClassForInitializers;
		allowClassVariableReferences: mclass == self namedReferent;
		compile: (newString := aString copy)
			in: nil
			allowReceiver: false
			class: mclass
			environment: env
			noPattern: true
			notifying: nil
			ifFail: [self error: 'Can''t complete compilation of this initializer'].
	method containingEnvironment: self namedReferent.
	(newString := newString copy)
		nextPut: 'foo';
		nextPut: 'bar';
		nextPut: 'zork'.
	^BlockClosure newCleanMethod: method
]
