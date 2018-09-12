private-accessing
elements
	
	^elements isNil
		ifTrue: [elements := self elementsClass new]
		ifFalse: [elements]