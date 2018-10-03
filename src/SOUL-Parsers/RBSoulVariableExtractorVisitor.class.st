Class {
	#name : #RBSoulVariableExtractorVisitor,
	#superclass : #RBProgramNodeVisitor,
	#instVars : [
		'dict'
	],
	#category : 'SOUL-Parsers'
}

{ #category : #'instance creation' }
RBSoulVariableExtractorVisitor class >> new [
	
	^super new initialize
]

{ #category : #initialize }
RBSoulVariableExtractorVisitor >> initialize [
	
	dict := Dictionary new
]

{ #category : #access }
RBSoulVariableExtractorVisitor >> variables [
	
	^dict values asOrderedCollection
]

{ #category : #'visitor - double dispatching' }
RBSoulVariableExtractorVisitor >> visitDelayedSoulVariable: aSoulVariable [
	
	dict
		at: aSoulVariable name
		put: (SoulFactory current makeDelayedVariable name: aSoulVariable name)
]

{ #category : #'visitor - double dispatching' }
RBSoulVariableExtractorVisitor >> visitSoulVariable: aSoulVariable [
	
	dict
		at: aSoulVariable name
		put: (SoulFactory current makeVariable name: aSoulVariable name)
]
