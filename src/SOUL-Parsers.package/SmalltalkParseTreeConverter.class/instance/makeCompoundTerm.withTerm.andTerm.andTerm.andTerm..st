private
makeCompoundTerm: aString withTerm: aTerm andTerm: aSecondTerm andTerm: aThirdTerm andTerm: aFourthTerm
	
	^SoulFactory current makeCompound
		functor: (Constant name: aString asSymbol)
		termSequence:
			(TermSequence
				terms:
					(OrderedCollection with: aTerm with: aSecondTerm with: aThirdTerm with:
							aFourthTerm))