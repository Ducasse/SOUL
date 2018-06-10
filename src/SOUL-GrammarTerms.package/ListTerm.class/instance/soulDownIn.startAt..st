reification
soulDownIn: anEnv startAt: anIndex
	"downing a compoundterm means downing myself and downing my  
	subterms. HOWEVER: We must up the subterms because they are  
	included in a listterm"

	
	| newTermSequence |
	newTermSequence := termsequence soulDownIn: anEnv startAt: anIndex.
	^self class functor: functor termSequence: newTermSequence