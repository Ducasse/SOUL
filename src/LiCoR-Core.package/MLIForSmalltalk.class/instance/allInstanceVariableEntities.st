reification - entities
allInstanceVariableEntities
	"Returns all existing instance variables."

	"We use a Set in the implementation below to avoid producing duplicates in the result."

	
	^self allBaseClassEntities
		inject: Set new
		into:
			[:sub :el | 
			(self allInstanceVariableEntitiesInClass: el)
				addAll: sub;
				yourself]