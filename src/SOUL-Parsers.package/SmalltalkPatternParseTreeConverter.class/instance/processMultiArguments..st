private
processMultiArguments: aCollection
	
	^SoulFactory current makeList
		termSequence:
			(TermSequence
				terms: (aCollection collect: [:each | self processArgument: each]))