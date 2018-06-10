private - storage
selectorForPredicateKey: aKey
	
	^((((aKey copyReplaceAll: ':' with: 'X') copyReplaceAll: '/' with: 'M')
		copyReplaceAll: '=' with: 'E') copyReplaceAll: '@' with: 'Q') asSymbol