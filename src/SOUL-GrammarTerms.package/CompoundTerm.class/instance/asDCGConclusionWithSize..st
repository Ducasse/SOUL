converting
asDCGConclusionWithSize: aSize
	
	termsequence terms add: (SoulFactory current makeVariable name: 'tokens1').
	termsequence terms
		add: (SoulFactory current makeVariable name: 'tokens' , aSize asString).
	^self