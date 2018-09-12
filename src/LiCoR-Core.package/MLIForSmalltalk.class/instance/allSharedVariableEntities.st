reification - entities
allSharedVariableEntities
	"Returns all existing shared variables."

	
	^(self allNamespaceEntities
		addAll: self allClassEntitiesAsNamespaceEntities)
		inject: Set new
		into:
			[:sub :el | 
			(self allSharedVariableEntitiesInNamespace: el)
				addAll: sub;
				yourself]