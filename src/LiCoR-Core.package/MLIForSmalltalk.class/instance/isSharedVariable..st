reification - entities
isSharedVariable: aVar
	"Returns true if aVar is a shared variable"

	
	^((self allNamespaceEntities
		addAll: self allClassEntitiesAsNamespaceEntities)
		detect: [:ns | self isSharedVariable: aVar inNamespace: ns]
		ifNone: [nil]) isNil not