building SOUL
buildKeywordedCompound: keyword firstTerm: term
	
	^SoulFactory current makeMessageTerm
		functor: (SoulFactory current makeKeywordFunctor keyword: keyword)
		termSequence: (self buildTermSequence: term)