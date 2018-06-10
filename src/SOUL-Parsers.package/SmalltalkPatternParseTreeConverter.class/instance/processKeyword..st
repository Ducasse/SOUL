private
processKeyword: anRBKeyword
	
	^anRBKeyword isPatternVariable
		ifTrue: [self processSelectorVariable: anRBKeyword]
		ifFalse: [anRBKeyword value]