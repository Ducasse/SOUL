visitor
accept: aVisitor
	"Every term can be visited by a visitor and should implement this part of the design pattern

	Note that the accept method must return the value of the visit message."

	
	^self subclassResponsibility