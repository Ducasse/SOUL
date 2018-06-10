instance creation
fromString: aString variables: variables content: terms block: aBlock
	
	| instance |
	instance := super fromString: aString.
	instance variables: variables content: terms block: aBlock.
	^instance