traversal
foo
	
	| newString |
	1
		to: 10
		do: [:each | each halt].
	^self
		compile: (newString := self copy);
		zork