reification - entities
allClassEntities
	"Returns a collection containing all the Smalltalk classes and metaclasses."

	
	^(self allMetaClassEntities)
		addAll: self allBaseClassEntities;
		yourself