Extension { #name : #UppedObject }

{ #category : #'*LiCoR-Core' }
UppedObject >> asRBNodeIn: anEnv startAt: anIndex [
	
	^self smalltalkValue asRBNodeIn: anEnv startAt: anIndex	"^RBLiteralValueNode value: (self smalltalkValue)."
]
