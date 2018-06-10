accessing
name
	
	^(keywords
		inject: ''
		into: [:concatenated :keyword | concatenated , keyword name , ':'])
		asSymbol