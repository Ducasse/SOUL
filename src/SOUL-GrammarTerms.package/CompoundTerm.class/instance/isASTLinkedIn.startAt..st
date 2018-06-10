access
isASTLinkedIn: anEnv startAt: index
	
	^((self astLink soulDownIn: anEnv startAt: index) isKindOf: Variable) not