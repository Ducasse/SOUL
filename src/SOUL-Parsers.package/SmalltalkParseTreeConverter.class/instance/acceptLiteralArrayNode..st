visitor-double dispatching
acceptLiteralArrayNode: aRBLiteralArrayNode
	"This not right yet... this code merely avoids an error"

	
	^self
		makeCompoundTerm: 'array'
		withTerms:
			(OrderedCollection with: (self visitNodes: aRBLiteralArrayNode contents))