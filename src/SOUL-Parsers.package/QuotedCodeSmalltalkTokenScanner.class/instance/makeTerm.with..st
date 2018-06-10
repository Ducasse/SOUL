private
makeTerm: aFunctorSymbol with: anArgument
	
	^SoulFactory current makeCompound
		functor: (Constant name: aFunctorSymbol)
		termSequence:
			(TermSequence terms: (Array with: (Constant name: anArgument)))