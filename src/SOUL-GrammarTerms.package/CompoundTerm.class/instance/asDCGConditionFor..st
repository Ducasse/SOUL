converting
asDCGConditionFor: counter
	
	(#(#not #and #or) includes: self functor name)
		ifTrue: [self error: 'Cannot use and/or/not in DCG production']
		ifFalse:
			[termsequence terms
				add: (SoulFactory current makeVariable name: 'tokens' , counter asString).
			termsequence terms
				add:
					(SoulFactory current makeVariable name: 'tokens' , (counter + 1) asString)]