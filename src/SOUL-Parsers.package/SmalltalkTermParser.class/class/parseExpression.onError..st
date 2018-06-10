accessing
parseExpression: aString onError: aBlock
	
	^self
		parse: aString
		startingAt: self startingStateForSequenceNode
		onError: aBlock