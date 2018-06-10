converting
messageSelector
	"UGLY: this assumes the keyword is a constant, it might also be a variable ..."

	
	^(keywords
		inject: ''
		into: [:concatenated :keyword | concatenated , keyword name , ':'])
		asSymbol