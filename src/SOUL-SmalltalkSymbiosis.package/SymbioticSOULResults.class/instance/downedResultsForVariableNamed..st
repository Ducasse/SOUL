public access
downedResultsForVariableNamed: aString
	
	| collection |
	collection := super downedResultsForVariableNamed: aString.
	^collection size = 1
		ifTrue: [FakeSingleItemCollection on: collection first]
		ifFalse:
			[(collection allSatisfy: [:element | element == true])
				ifTrue: [true]
				ifFalse: [collection]]