reification - binary relations
isInstanceVariable: aVar inClass: aClass
	"Returns true if aVar is an instance variable of class aClass. Return 
	false otherwise."

	
	^(self allInstanceVariableEntitiesInClass: aClass) includes: aVar