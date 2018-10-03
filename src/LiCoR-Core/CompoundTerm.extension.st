Extension { #name : #CompoundTerm }

{ #category : #'*LiCoR-Core' }
CompoundTerm >> asRBNodeIn: anEnv startAt: anIndex [
	
	| aRBNode aRBNodeClass children |
	aRBNodeClass := (Browser bindingFor: self functor smalltalkValue) value.
	aRBNode := aRBNodeClass new.
	children := self rbNodeChildrenIn: anEnv startAt: anIndex.
	aRBNode soulChildren: children.
	^aRBNode
]

{ #category : #'*LiCoR-Core' }
CompoundTerm >> asSourceStringIn: anEnv startAt: anIndex [
	
	^(self asRBNodeIn: anEnv startAt: anIndex) asSourceString
]

{ #category : #'*LiCoR-Core' }
CompoundTerm >> rbNodeChildrenIn: anEnv startAt: anIndex [
	
	^self termSequence terms
		collect: [:aTerm | aTerm asRBNodeIn: anEnv startAt: anIndex]
]
