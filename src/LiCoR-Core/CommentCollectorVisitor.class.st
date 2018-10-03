Class {
	#name : #CommentCollectorVisitor,
	#superclass : #RBProgramNodeVisitor,
	#instVars : [
		'comments'
	],
	#category : 'LiCoR-Core'
}

{ #category : #accessing }
CommentCollectorVisitor >> allCollectedComments [
	
	^comments
]

{ #category : #'initialize-release' }
CommentCollectorVisitor >> initialize [
	
	super initialize.
	comments := OrderedCollection new
]

{ #category : #visiting }
CommentCollectorVisitor >> visitNode: node [

	node comments do: [ :commentNode | comments add: commentNode contents ].
	^ super visitNode: node
]

{ #category : #visiting }
CommentCollectorVisitor >> visitTemporaryNode: node [

	node comments do: [ :commentNode | comments add: commentNode contents ].
	^ super visitTemporaryNode: node
]
