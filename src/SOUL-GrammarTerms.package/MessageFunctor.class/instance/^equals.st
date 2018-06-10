comparing
= anObject
	
	^(anObject isKindOf: MessageFunctor)
		ifTrue: [anObject keywords = keywords]
		ifFalse: [super = anObject]