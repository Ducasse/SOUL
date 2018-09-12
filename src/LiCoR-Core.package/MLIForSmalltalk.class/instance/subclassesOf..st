reification - binary relations
subclassesOf: aClassOrNil
	"returns a stream containing the subclasses for the  
	argument, aClassOrNil.  
	aClassOrNil can be nil, so take care"

	
	^aClassOrNil isNil
		ifTrue: [Class rootsOfTheWorld]
		ifFalse: [aClassOrNil subclasses asArray]