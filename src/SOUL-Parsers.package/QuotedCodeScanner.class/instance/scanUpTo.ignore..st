scanning
scanUpTo: stopChar ignore: startChar
	
	| level |
	level := 0.
	self step.
	[currentCharacter = stopChar and: [level = 0]]
		whileFalse:
			[currentCharacter = startChar ifTrue: [level := level + 1].
			currentCharacter = stopChar ifTrue: [level := level - 1].
			currentCharacter = $# ifTrue: [self step].
			currentCharacter = $'
				ifTrue:
					[self step.
					self innerScanUpTo: $' ignore: nil].
			currentCharacter = $$ ifTrue: [self step].
			self atEnd
				ifTrue: [self error: 'Unmatched ' , startChar asString]
				ifFalse: [self step]]	"self getNextChar."
	"self token: outputStream contents"