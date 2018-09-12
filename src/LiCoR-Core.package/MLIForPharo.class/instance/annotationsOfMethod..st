method attributes
annotationsOfMethod: aMethod
	| result pragmas |
	result := OrderedCollection new.
	pragmas := aMethod compiledMethod pragmas.
	pragmas do: [:each | result add: each keyword -> each arguments].
	^result