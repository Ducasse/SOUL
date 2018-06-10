controlling
ifTrue: alternativeBlock
	"Answer the value of alternativeBlock. This method is typically not 
	invoked because ifTrue:/ifFalse: expressions are compiled in-line for 
	literal blocks."

	
	^alternativeBlock value