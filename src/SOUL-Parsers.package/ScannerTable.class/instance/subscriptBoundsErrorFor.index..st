error handling
subscriptBoundsErrorFor: selector index: index
	"This method is invoked when a subscript is an integer but is out of range.
	 Answer an appropriate default value."

	
	| char |
	index = 0 ifTrue: [^value0].
	(index
		between: self size + 1
		and: Character maxValue)
		ifFalse: [^super subscriptBoundsErrorFor: selector index: index].
	char := Character value: index.
	char isLetter ifTrue: [^letterValue].
	char isSeparator ifTrue: [^separatorValue].
	char isDigit ifTrue: [^digitValue].
	^defaultValue