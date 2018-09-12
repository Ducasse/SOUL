*LiCoR-Core
asRBNodeIn: anEnv startAt: anIndex
	
	| asRBNode |
	asRBNode := self soulDownIn: anEnv startAt: anIndex.
	asRBNode = self
		ifFalse: [^asRBNode]
		ifTrue: [^self asString]