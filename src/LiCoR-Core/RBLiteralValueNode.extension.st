Extension { #name : #RBLiteralValueNode }

{ #category : #'*LiCoR-Core' }
RBLiteralValueNode >> soulChildren [
	
	^Array with: self value
]

{ #category : #'*LiCoR-Core' }
RBLiteralValueNode >> soulChildren: children [
	
	self token: (RBLiteralToken value: (children at: 1))
]

{ #category : #'*LiCoR-Core' }
RBLiteralValueNode >> unifyWith: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: aBool [
	"GENERATED BY UNIFICATION EDITOR - DO NOT EDIT MANUALLY !!"

	
	^aTerm
		unifyWithRBLiteralValueNode: self
		inEnv: anEnv
		myIndex: hisIndex
		hisIndex: myIndex
		inSource: aBool not
]

{ #category : #'*LiCoR-Core' }
RBLiteralValueNode >> unifyWithRBLiteralValueNode: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: aBool [
	
	^self = aTerm
]