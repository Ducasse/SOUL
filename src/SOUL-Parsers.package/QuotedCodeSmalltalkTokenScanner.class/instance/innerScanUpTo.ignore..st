scanner directives
innerScanUpTo: stopChar ignore: startChar
	
	| level |
	level := 0.
	[hereChar = stopChar and: [level = 0]]
		whileFalse:
			[hereChar = startChar ifTrue: [level := level + 1].
			hereChar = stopChar ifTrue: [level := level - 1].
			hereChar == nil
				ifTrue: [self error: 'Unmatched ' , startChar asString]
				ifFalse: [self getNextChar]]