comparing
= anObject
	
	^(anObject isKindOf: KeywordFunctor)
		ifTrue: [anObject keywords = keywords]
		ifFalse: [super = anObject]