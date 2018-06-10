instance creation
name: aName
	
	^self
		keywords:
			(aName asSymbol keywords
				collect:
					[:keywordName | SoulFactory current makeConstant name: (keywordName allButLast: 1) asSymbol])