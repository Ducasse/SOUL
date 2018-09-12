reification - binary relations
classMethodsInClass: aClass
	
	| aClassClass |
	aClassClass := aClass class.
	^aClassClass selectors
		collect:
			[:sel | self smalltalkMethodClass class: aClassClass selector: sel]