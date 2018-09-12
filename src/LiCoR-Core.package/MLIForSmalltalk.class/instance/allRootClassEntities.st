reification - entities
allRootClassEntities
	"Returns all the root classes (= classes that have no superclasses) in the current image."

	
	^self allBaseClassEntities select: [:cl | self isRootClass: cl]