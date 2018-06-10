controlling
ifTrue: trueAlternativeBlock ifFalse: falseAlternativeBlock
	"Answer the value of trueAlternativeBlock. This method is typically 
	not invoked because ifTrue:/ifFalse: expressions are compiled in-line 
	for literal blocks."

	
	^trueAlternativeBlock value