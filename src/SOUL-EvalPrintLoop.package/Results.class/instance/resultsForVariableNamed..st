public-access
resultsForVariableNamed: aString
	
	^self success
		ifTrue: [self results at: (self variableNamed: aString)]
		ifFalse: [#()]