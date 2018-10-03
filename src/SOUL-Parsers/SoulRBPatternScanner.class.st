Class {
	#name : #SoulRBPatternScanner,
	#superclass : #RBPatternScanner,
	#category : 'SOUL-Parsers'
}

{ #category : #'class initialization' }
SoulRBPatternScanner class >> initializeClassificationTable [
	"self initialize"

	
	super initializeClassificationTable	"PatternVariableCharacter := $?"
]
