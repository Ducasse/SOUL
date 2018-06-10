converting
asDCGConditionFor: counter
	
	| terms |
	terms := OrderedCollection new.
	terms
		add: (SoulFactory current makeVariable name: 'tokens' , counter asString).
	terms
		add:
			(SoulFactory current makeVariable name: 'tokens' , (counter + 1) asString).
	^SoulFactory current makeCompound
		functor: self
		termSequence: (TermSequence terms: terms)