reification - entities
isBaseClass: arg
	"has to return true if the argument arg is a base class, false otherwise"

	
	^(self isMetaClass: arg) not and: [self isClass: arg]