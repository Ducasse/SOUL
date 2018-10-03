Extension { #name : #UndefinedObject }

{ #category : #'*LiCoR-Core' }
UndefinedObject >> current [
	"DEPRECATED"

	"returns the current Meta-Level Interface to be used. This can be 
	changed using the #setCurrentMLI: method"

	
	^self getMLIFor: #Smalltalk
]

{ #category : #'*LiCoR-Core' }
UndefinedObject >> forSmalltalk [
	
	^self getMLIFor: #Smalltalk
]
