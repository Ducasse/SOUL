reification - entities
isInstanceVariable: aVar
	"Returns true if aVar is an instance variable of some class."

	
	^(self allBaseClassEntities
		detect: [:class | self isInstanceVariable: aVar inClass: class]
		ifNone: [nil]) isNil not