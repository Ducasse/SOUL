comparing
= anObject
	
	^(anObject isKindOf: UppedObject)
		ifTrue: [anObject smalltalkValue = self smalltalkValue]
		ifFalse: [super = anObject]