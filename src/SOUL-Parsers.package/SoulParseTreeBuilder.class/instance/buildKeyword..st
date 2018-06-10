building SOUL
buildKeyword: anIdentifierString
	
	^SoulFactory current makeConstant
		name: (anIdentifierString allButLast: 1) asSymbol