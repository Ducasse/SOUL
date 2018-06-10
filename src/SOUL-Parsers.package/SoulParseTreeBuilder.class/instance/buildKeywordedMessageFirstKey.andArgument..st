building SOUL
buildKeywordedMessageFirstKey: keyword andArgument: argument
	
	^SoulFactory current makeMessageTerm
		functor: (SoulFactory current makeMessageFunctor keyword: keyword)
		termSequence: (self buildTermSequence: argument)