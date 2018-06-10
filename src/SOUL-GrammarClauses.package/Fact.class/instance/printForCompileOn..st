printing
printForCompileOn: aStream
	"see comment in AbstractClause"

	
	aStream write: '(' , self class name , ' conclusion:( '.
	conclusion printForCompileOn: aStream.
	aStream write: '))'.
	self hasComment
		ifTrue:
			[aStream write: ' comment: ' , self comment storeString , '; yourself']