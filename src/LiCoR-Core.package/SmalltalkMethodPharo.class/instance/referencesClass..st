information extraction
referencesClass: aClass
	
	^self compiledMethod literals
		anySatisfy:
			[:literal | literal isVariableBinding and: [literal value == aClass]]