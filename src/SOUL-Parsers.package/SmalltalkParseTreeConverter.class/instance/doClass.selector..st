public access
doClass: aClass selector: aSymbol
	
	| source |
	methodClassTerm := SoulFactory current makeUppedObject up: aClass.
	source := aClass compilerClass = Object compilerClass
		ifTrue: [(aClass sourceCodeAt: aSymbol) string]
		ifFalse: [aSymbol asString].
	^self doString: source inClass: aClass