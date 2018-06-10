building SOUL
buildSymbol: anIdentifierString
	
	^SoulFactory current makeConstant
		name:
			(anIdentifierString
				copyFrom: 2
				to: anIdentifierString size) asSymbol