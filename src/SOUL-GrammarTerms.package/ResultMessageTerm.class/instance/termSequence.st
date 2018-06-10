accessing
termSequence
	
	^SoulFactory current makeTermSequence
		terms:
			((messageTerm termSequence terms copy)
				add: resultTerm;
				yourself)