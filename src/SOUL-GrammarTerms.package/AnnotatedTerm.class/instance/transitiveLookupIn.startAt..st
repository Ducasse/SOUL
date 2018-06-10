reification
transitiveLookupIn: anEnv startAt: anIndex
	
	| newterm newAnnotation |
	newAnnotation := annotation transitiveLookupIn: anEnv startAt: anIndex.
	newterm := term transitiveLookupIn: anEnv startAt: anIndex.
	^(self class term: newterm annotation: newAnnotation)
		definitionRepository: self definitionRepository