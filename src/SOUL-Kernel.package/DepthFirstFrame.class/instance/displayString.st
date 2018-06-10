printing
displayString
	
	| stream current |
	stream := WriteStream on: String new.
	current := conditionsList.
	[current == nil]
		whileFalse:
			[stream nextPutAll: conditionsList displayString , ' , '.
			current := current nextTerm].
	^stream contents