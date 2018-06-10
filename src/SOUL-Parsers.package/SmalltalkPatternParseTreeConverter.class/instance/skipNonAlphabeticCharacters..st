private
skipNonAlphabeticCharacters: aString
	
	^aString select: [:el | el isAlphaNumeric]