private - storage
parseInstanceStorageMethod: selector
	
	^SoulFactory current makeParser
		parseAfterRemovingSelector: (self sourceCodeAt: selector)