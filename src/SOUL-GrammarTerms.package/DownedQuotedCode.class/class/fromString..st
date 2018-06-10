instance creation
fromString: aString
	
	| qc |
	qc := QuotedCodeTerm source: aString.
	^self
		fromString: aString
		variables: qc variablesIncludingNils
		content: qc content
		block: qc block