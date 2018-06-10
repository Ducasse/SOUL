private
makeCompoundTerm: aString withTerm: aTerm
	
	^SoulFactory current makeCompound
		functor: (Constant name: aString asSymbol)
		termSequence: (TermSequence terms: (OrderedCollection with: aTerm))