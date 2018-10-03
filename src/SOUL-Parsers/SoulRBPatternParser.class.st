Class {
	#name : #SoulRBPatternParser,
	#superclass : #RBPatternParser,
	#category : 'SOUL-Parsers'
}

{ #category : #accessing }
SoulRBPatternParser >> scannerClass [
	
	^SoulRBPatternScanner
]

{ #category : #'private-classes' }
SoulRBPatternParser >> variableNodeClass [
	
	^SoulRBPatternVariableNode
]
