public accessing
parseSelectorInterval: aString
	"inspired from Parser"

	
	| selector |
	selector := self parseSelector: aString.
	^selector isNil
		ifTrue: [1 to: 0]
		ifFalse: [1 to: selector size]