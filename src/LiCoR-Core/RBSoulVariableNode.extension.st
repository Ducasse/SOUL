Extension { #name : #RBSoulVariableNode }

{ #category : #'*LiCoR-Core' }
RBSoulVariableNode >> unifyWith: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: aBool [
	"GENERATED BY UNIFICATION EDITOR - DO NOT EDIT MANUALLY !!"

	
	^aTerm
		unifyWithRBSoulVariableNode: self
		inEnv: anEnv
		myIndex: hisIndex
		hisIndex: myIndex
		inSource: aBool not
]

{ #category : #'*LiCoR-Core' }
RBSoulVariableNode >> unifyWithRBSoulVariableNode: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: aBool [
	
	^self = aTerm
]
