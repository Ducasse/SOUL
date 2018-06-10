private
predicateKeyAsSelector: aKey
	
	^(((aKey copyReplaceAll: ':' with: 'X') copyReplaceAll: '/' with: 'M')
		copyReplaceAll: '=' with: 'E') asSymbol