scanner directives
scanUpTo: stopChar ignore: startChar
	
	| level |
	level := 0.
	[hereChar = stopChar and: [level = 0]]
		whileFalse:
			[hereChar = startChar ifTrue: [level := level + 1].
			hereChar = stopChar ifTrue: [level := level - 1].
			hereChar = $# ifTrue: [self getNextChar].
			hereChar = $'
				ifTrue:
					[self getNextChar.
					self innerScanUpTo: $' ignore: nil].
			hereChar = $$ ifTrue: [self getNextChar].
			hereChar == nil
				ifTrue: [self error: 'Unmatched ' , startChar asString]
				ifFalse: [self getNextChar]].
	self getNextChar