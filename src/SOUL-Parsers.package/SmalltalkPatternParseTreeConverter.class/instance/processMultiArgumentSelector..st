private
processMultiArgumentSelector: aCollection
	
	^SoulFactory current makeList
		termSequence:
			(TermSequence
				terms: (aCollection collect: [:each | self processKeyword: each]))