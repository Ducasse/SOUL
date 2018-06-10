private
prepareQuery: aQuery
	"(Query condition: continuationQuery condition copy)"

	
	^aQuery accept: CopyingVisitor new