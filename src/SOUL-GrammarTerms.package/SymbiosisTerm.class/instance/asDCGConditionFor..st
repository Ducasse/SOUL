converting
asDCGConditionFor: aCounter
	
	| tokens1var tokens2var equals |
	tokens1var := SoulFactory current makeVariable
		name: 'tokens' , aCounter asString.
	tokens2var := SoulFactory current makeVariable
		name: 'tokens' , (aCounter + 1) asString.
	equals := SoulFactory current makeCompound
		functor: (Constant name: #equals)
		termSequence:
			(TermSequence terms: (OrderedCollection with: tokens1var with: tokens2var)).
	^SoulFactory current makeCompound
		functor: (Constant name: #and)
		termSequence:
			(TermSequence terms: (OrderedCollection with: self with: equals))