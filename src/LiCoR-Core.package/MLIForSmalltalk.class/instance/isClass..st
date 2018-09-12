reification - entities
isClass: arg
	"returns true if the argument arg is a Smalltalk class or metaclass, false otherwise"

	
	^arg respondsTo: #basicNew