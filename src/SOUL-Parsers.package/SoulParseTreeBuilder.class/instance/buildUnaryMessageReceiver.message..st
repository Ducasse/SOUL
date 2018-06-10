building SOUL
buildUnaryMessageReceiver: receiver message: message
	
	^SoulFactory current makeMessageTerm
		functor: message
		termSequence: (SoulFactory current makeTermSequence term: receiver)