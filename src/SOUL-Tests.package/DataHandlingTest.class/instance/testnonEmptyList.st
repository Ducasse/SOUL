list handling
testnonEmptyList
	"nonEmptyList/1"

	
	self processQuery: ' if fails(nonEmptyList(<>))' description:
			'Is the empty list <> not non-empty?'.
	self processQuery: ' if succeeds(nonEmptyList(<a,b,c,b>))' description:
			'Is <a,b,c> a non-empty list?'