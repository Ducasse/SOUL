*LiCoR-Core
asRBNodeIn: anEnv startAt: anIndex
	
	| aRBNode aRBNodeClass children |
	aRBNodeClass := (Browser bindingFor: self functor smalltalkValue) value.
	aRBNode := aRBNodeClass new.
	children := self rbNodeChildrenIn: anEnv startAt: anIndex.
	aRBNode soulChildren: children.
	^aRBNode