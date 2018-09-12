packaging - entities
allProtocolEntities
	
	| prots |
	prots := Set new.
	self allClassEntities
		do: [:aClass | prots addAll: (self allProtocolsOfClass: aClass)].
	^prots