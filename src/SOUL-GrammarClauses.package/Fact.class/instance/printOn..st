printing
printOn: aStream
	"see comment in AbstractClause"

	
	self printCommentOn: aStream.
	conclusion printOn: aStream