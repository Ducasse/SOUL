*LiCoR-Core
asRBNodeIn: anEnv startAt: anIndex
	
	| nodes |
	"^(self collectIn: anEnv startAt: anIndex) collect: [ :aTerm | aTerm asRBNodeIn: anEnv startAt: anIndex]. "

	nodes := OrderedCollection new.
	self
		listDo: [:aTerm | nodes add: (aTerm asRBNodeIn: anEnv startAt: anIndex)].
	^nodes