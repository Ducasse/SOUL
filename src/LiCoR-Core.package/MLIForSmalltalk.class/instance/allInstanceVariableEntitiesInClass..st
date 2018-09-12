reification - binary relations
allInstanceVariableEntitiesInClass: aClass
	"Returns a collection containg all the instance variables of class aClass."

	
	^(aClass instVarNames collect: [:each | each asSymbol])
		asOrderedCollection