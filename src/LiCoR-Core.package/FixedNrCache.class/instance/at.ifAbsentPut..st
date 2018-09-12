adding-removing
at: aKey ifAbsentPut: elementCreationBlock
	"If it exists, return the element from the cache. If it doesn't not exist, evaluate the 
	block and add abd return the element it describes"

	
	| element |
	^(self includesKey: aKey)
		ifTrue: [self basicAt: aKey]
		ifFalse:
			[self
				at: aKey
				put: (element := elementCreationBlock value).
			element]