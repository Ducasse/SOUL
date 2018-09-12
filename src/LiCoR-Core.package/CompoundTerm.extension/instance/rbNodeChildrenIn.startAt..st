*LiCoR-Core
rbNodeChildrenIn: anEnv startAt: anIndex
	
	^self termSequence terms
		collect: [:aTerm | aTerm asRBNodeIn: anEnv startAt: anIndex]