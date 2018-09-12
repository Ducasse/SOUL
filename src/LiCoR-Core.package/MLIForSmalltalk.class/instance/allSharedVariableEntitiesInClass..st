reification - binary relations
allSharedVariableEntitiesInClass: aClass
	"Returns a collection containg all the instance variables of class aClass."

	
	^aClass asNameSpace localBindings asOrderedCollection