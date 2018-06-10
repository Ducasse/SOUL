private
processSelector: aMessageNode
	
	^aMessageNode selectorParts size > 1
		ifTrue: [self processMultiArgumentSelector: aMessageNode selectorParts]
		ifFalse:
			[self processSingleArgumentSelector: (aMessageNode selectorParts at: 1)]