*LiCoR-Core
asRBNodeIn: anEnv startAt: anIndex
	
	^self collect: [:v | v asRBNodeIn: anEnv startAt: anIndex]