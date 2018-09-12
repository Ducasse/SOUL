reification - entities
allClassVariableEntities
	"Returns all existing class variables."

	"We use a Set in the implementation below to avoid producing duplicates in the result."

	
	^self allMetaClassEntities
		inject: Set new
		into:
			[:sub :el | 
			(self allInstanceVariableEntitiesInClass: el)
				addAll: sub;
				yourself]