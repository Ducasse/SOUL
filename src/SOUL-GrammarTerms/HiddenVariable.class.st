Class {
	#name : #HiddenVariable,
	#superclass : #Variable,
	#category : 'SOUL-GrammarTerms'
}

{ #category : #visitor }
HiddenVariable >> accept: aVisitor [
	"see comment in AbstractTerm"

	
	^aVisitor hiddenVariableVisit: self
]

{ #category : #testing }
HiddenVariable >> isHiddenVariable [
	
	^true
]
