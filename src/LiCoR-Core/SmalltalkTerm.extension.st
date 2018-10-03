Extension { #name : #SmalltalkTerm }

{ #category : #'*LiCoR-Core' }
SmalltalkTerm >> asRBNodeIn: anEnv startAt: anIndex [
	
	self isLiteral
		ifTrue:
			["^RBLiteralToken value: self literalValue."

			^self literalValue]
		ifFalse:
			["TODO"

			self halt.
			^self source]
]
