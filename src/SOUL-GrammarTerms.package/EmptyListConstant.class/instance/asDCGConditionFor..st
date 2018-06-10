converting
asDCGConditionFor: counter
	
	| tokens1var tokens2var terminals |
	terminals := OrderedCollection new.
	self listDo: [:aTerm | terminals add: aTerm].
	tokens1var := SoulFactory current makeVariable
		name: 'tokens' , counter asString.
	tokens2var := SoulFactory current makeVariable
		name: 'tokens' , (counter + 1) asString.
	^SoulFactory current makeCompound
		functor: (Constant name: #equals)
		termSequence:
			(TermSequence terms: (OrderedCollection with: tokens1var with: tokens2var))