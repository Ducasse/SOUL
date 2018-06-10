printing
prettyPrintOn: aStream scope: id
	"see comment in AbstractClause"

	
	self prettyPrintCommentOn: aStream.
	conclusion prettyPrintOn: aStream scope: id