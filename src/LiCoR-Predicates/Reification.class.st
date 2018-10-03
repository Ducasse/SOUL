"
The Reification layer reifies the basic Smalltalk entities.

It is split up in PackagingReification and SmalltalkReification.
The reason for doing so is that packaging is essentially an environment issue
(there are no real language primitives that deal with packaging), whereas the
Smalltalk reification reifies the Smalltalk primitive language constructs.
"
Class {
	#name : #Reification,
	#superclass : #SmalltalkReasoning,
	#category : 'LiCoR-Predicates'
}

{ #category : #'method attributes' }
Reification >> methodWithPragmaNamedM2 [

methodWithPragmaNamed(-?method,+?name) if 
	class(?class),member(?method,[MLI forSmalltalk
	methodsInClass: ?class
	withPragmaName: ?name asSymbol]).
methodWithPragmaNamed(+?method,+?name) if 
	methodInClass(?method,?class),member(?method,[MLI forSmalltalk
	methodsInClass: ?class
	withPragmaName: ?name asSymbol])
]
