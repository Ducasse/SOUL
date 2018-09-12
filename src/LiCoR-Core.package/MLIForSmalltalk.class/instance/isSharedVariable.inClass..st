reification - binary relations
isSharedVariable: aVar inClass: aClass
	"Returns true if aVar is a shared variable of class aClass. Return 
	false otherwise."

	
	^self
		isSharedVariable: aVar
		inNamespace: aClass asNameSpace