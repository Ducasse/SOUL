converting
asList
	
	^SoulFactory current makeList
		termSequence:
			(TermSequence new terms: (content collect: [:each | each quotedCodeToList]))