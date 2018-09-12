packaging - binary relations
packageForClass: aClass
	^aClass isMeta 
		ifTrue:[aClass soleInstance category]
		ifFalse:[aClass category]