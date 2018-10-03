Extension { #name : #Collection }

{ #category : #'*LiCoR-Core' }
Collection >> asRBNodeIn: anEnv startAt: anIndex [
	
	^self collect: [:v | v asRBNodeIn: anEnv startAt: anIndex]
]
