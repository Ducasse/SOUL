private-accessing
order
	"return the order. This is an OrderedCollection containing the order in which 
	keys were added"

	
	^order isNil
		ifTrue: [order := self orderClass new]
		ifFalse: [order]