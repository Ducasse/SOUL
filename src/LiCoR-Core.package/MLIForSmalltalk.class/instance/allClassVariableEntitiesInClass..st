reification - binary relations
allClassVariableEntitiesInClass: aClass
	"Returns a collection containg all the class variables of class aClass."

	
	^(aClass class instVarNames collect: [:each | each asSymbol])
		asOrderedCollection