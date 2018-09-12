comparing
= anObject
	
	^(anObject isKindOf: self class)
		ifTrue:
			[(anObject selector = self selector & anObject fromClass) = self fromClass]
		ifFalse: [false]