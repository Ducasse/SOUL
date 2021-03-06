Extension { #name : #RBReturnNode }

{ #category : #'*LiCoR-Core' }
RBReturnNode >> soulChildren: children [
	
	self value: (children at: 1)
]

{ #category : #'*LiCoR-Core' }
RBReturnNode >> unifyWith: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: aBool [
	"GENERATED BY UNIFICATION EDITOR - DO NOT EDIT MANUALLY !!"

	
	^aTerm
		unifyWithRBReturnNode: self
		inEnv: anEnv
		myIndex: hisIndex
		hisIndex: myIndex
		inSource: aBool not
]

{ #category : #'*LiCoR-Core' }
RBReturnNode >> unifyWithRBReturnNode: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: aBool [
	
	^self = aTerm
]
