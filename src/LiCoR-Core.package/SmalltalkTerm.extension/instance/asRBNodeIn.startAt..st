*LiCoR-Core
asRBNodeIn: anEnv startAt: anIndex
	
	self isLiteral
		ifTrue:
			["^RBLiteralToken value: self literalValue."

			^self literalValue]
		ifFalse:
			["TODO"

			self halt.
			^self source]