visitor-double dispatching
acceptArrayNode: anArrayNode
	"This not right yet... this code merely avoids an error"

	
	^self
		makeCompoundTerm: 'braces'
		withTerms: (self visitNodes: anArrayNode messages)