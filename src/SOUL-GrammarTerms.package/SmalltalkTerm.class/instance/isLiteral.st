private
isLiteral
	
	^content statements size = 1
		and: [content statements first isKindOf: RBLiteralNode]