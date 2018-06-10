private
makeCompoundTerm: aString withTerms: aCollectionOfTerms
	
	^SoulFactory current makeCompound
		functor: (Constant name: aString asSymbol)
		termSequence: (TermSequence terms: aCollectionOfTerms)