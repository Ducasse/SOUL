printing
printAsPrologOn: aStream
	"TODO: not correct if fact contains positive or negative variables"

	
	conclusion printAsPrologOn: aStream scope: #asClause in: nil startAt: nil.
	aStream
		write: '.';
		cr