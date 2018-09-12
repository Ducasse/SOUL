reification - binary relations
methodsInClass: aClass
	
	^aClass selectors
		collect: [:sel | self smalltalkMethodClass class: aClass selector: sel]