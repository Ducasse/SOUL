converting
asDCGConclusionWithSize: aSize
	
	^SoulFactory current makeCompound
		functor: self
		termSequence:
			(TermSequence
				terms:
					(OrderedCollection
						with: (SoulFactory current makeVariable name: 'tokens1')
						with: (SoulFactory current makeVariable name: 'tokens' , aSize asString)))