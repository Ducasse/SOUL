enumeration
collectIn: anEnv startAt: anIndex
	
	| newCollection |
	newCollection := OrderedCollection new.
	self
		listDo:
			[:elt | newCollection add: (elt soulDownIn: anEnv startAt: anIndex)].
	^newCollection