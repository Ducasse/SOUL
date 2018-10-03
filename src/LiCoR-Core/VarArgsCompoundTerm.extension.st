Extension { #name : #VarArgsCompoundTerm }

{ #category : #'*LiCoR-Core' }
VarArgsCompoundTerm >> rbNodeChildrenIn: anEnv startAt: anIndex [
	
	^(super rbNodeChildrenIn: anEnv startAt: anIndex) first
]
