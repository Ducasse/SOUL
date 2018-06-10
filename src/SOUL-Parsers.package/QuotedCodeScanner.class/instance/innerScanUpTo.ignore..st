scanning
innerScanUpTo: stopChar ignore: startChar
	
	| level |
	level := 0.
	[currentCharacter = stopChar and: [level = 0]]
		whileFalse:
			[currentCharacter = startChar ifTrue: [level := level + 1].
			currentCharacter = stopChar ifTrue: [level := level - 1].
			self atEnd
				ifTrue: [self error: 'Unmatched ' , startChar asString]
				ifFalse: [self step]]