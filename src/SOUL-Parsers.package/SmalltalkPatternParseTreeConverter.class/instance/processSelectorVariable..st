private
processSelectorVariable: anRBKeywordToken
	
	^Variable name: (self skipNonAlphabeticCharacters: anRBKeywordToken value)