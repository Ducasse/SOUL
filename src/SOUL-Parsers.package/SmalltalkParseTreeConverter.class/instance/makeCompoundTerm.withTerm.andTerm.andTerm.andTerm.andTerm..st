private
makeCompoundTerm: aString withTerm: aTerm andTerm: aSecondTerm andTerm: aThirdTerm andTerm: aFourthTerm andTerm: aFifthTerm
	
	^SoulFactory current makeCompound
		functor: (Constant name: aString asSymbol)
		termSequence:
			(TermSequence
				terms:
					((OrderedCollection new: 5)
						add: aTerm;
						add: aSecondTerm;
						add: aThirdTerm;
						add: aFourthTerm;
						add: aFifthTerm;
						yourself))