reification - binary relations
allInstanceVariableEntitiesInClassChain: aClass
	"Returns a collection containing all the instance variables declared
	 somewhere in the class chain of aClass (i.e. in aClass itself or in
	 one of its superclassses."

	
	^(aClass allInstVarNames collect: [:each | each asSymbol])
		asOrderedCollection