reification - binary relations
isClassMethod: aMethod inClass: aClass
	"Returns true if aMethod is a CLASS method of class aClass. Return false otherwise."

	
	^(self isMethod: aMethod) and: [aClass class == aMethod fromClass]