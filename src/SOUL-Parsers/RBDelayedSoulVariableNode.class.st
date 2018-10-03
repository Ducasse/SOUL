Class {
	#name : #RBDelayedSoulVariableNode,
	#superclass : #RBSoulVariableNode,
	#category : 'SOUL-Parsers'
}

{ #category : #visitor }
RBDelayedSoulVariableNode >> acceptVisitor: aVisitor [
	
	^aVisitor visitDelayedSoulVariable: self
]
