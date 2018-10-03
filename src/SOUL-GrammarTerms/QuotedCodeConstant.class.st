Class {
	#name : #QuotedCodeConstant,
	#superclass : #Constant,
	#category : 'SOUL-GrammarTerms'
}

{ #category : #reification }
QuotedCodeConstant >> asSourceStringIn: anEnv startAt: anIndex [
	
	^self asString
]

{ #category : #printing }
QuotedCodeConstant >> printForCompileOn: aStream [
	"see comment in AbstractTerm"

	
	| x name |
	aStream write: self class name , ' name: '''.	"I should first convert every quote into a double quote"

	name := smalltalkValue asString.
	1
		to: name size
		do:
			[:i | 
			aStream write: (x := name at: i).
			x == $' ifTrue: [aStream write: x]].
	aStream write: ''''
]

{ #category : #printing }
QuotedCodeConstant >> printOn: aStream [
	
	aStream write: smalltalkValue asString
]

{ #category : #initialize }
QuotedCodeConstant >> setName: aName [
	
	self setSmalltalkValue: aName
]

{ #category : #converting }
QuotedCodeConstant >> smalltalkBlockString [
	
	^'''' , self asString , ''''
]

{ #category : #reification }
QuotedCodeConstant >> soulDownIn: anEnv startAt: anIndex [
	
	^self
]

{ #category : #reification }
QuotedCodeConstant >> transitiveLookupIn: anEnv startAt: anIndex [
	
	^self
]
