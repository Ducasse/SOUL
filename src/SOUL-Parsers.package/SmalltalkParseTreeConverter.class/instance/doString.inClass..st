public access
doString: aString inClass: aClass
	
	methodClassTerm := SoulFactory current makeUppedObject up: aClass.
	^self doString: aString