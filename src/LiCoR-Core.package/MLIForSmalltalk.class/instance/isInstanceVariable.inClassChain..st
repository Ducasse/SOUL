reification - binary relations
isInstanceVariable: aVar inClassChain: aClass
	"Returns true if aVar is an instance variable declared in the class chain of aClass
	 (i.e. in aClass or one of its superclasses). Return false otherwise."

	
	^aClass allInstVarNames includes: aVar asString