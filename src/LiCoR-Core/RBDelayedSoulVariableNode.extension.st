Extension { #name : #RBDelayedSoulVariableNode }

{ #category : #'*LiCoR-Core' }
RBDelayedSoulVariableNode >> unifyWith: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: aBool [
	"GENERATED BY UNIFICATION EDITOR - DO NOT EDIT MANUALLY !!"

	
	^aTerm
		unifyWithRBDelayedSoulVariableNode: self
		inEnv: anEnv
		myIndex: hisIndex
		hisIndex: myIndex
		inSource: aBool not
]

{ #category : #'*LiCoR-Core' }
RBDelayedSoulVariableNode >> unifyWithRBDelayedSoulVariableNode: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: aBool [
	
	^self = aTerm
]