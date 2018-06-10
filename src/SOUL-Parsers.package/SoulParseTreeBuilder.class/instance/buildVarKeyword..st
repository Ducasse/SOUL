building SOUL
buildVarKeyword: anIdentifierString
	
	^SoulFactory current makeVariable
		name: ((anIdentifierString allButFirst: 1) allButLast: 1)