reification - binary relations
isClassVariable: aVar inClass: aClass
	"returns true if aVar is a class variable of class aClass. Return false 
	otherwise "

	
	^self
		isInstanceVariable: aVar
		inClass: aClass class