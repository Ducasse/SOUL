reification - entities
isClassVariable: aVar
	"Returns true if aVar is an class variable of some class."

	
	^(self allBaseClassEntities
		detect: [:class | self isClassVariable: aVar inClass: class]
		ifNone: [nil]) isNil not