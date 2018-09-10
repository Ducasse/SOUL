list handling
testflatten
	"flatten/2"

	
	self processQuery: ' if succeeds(flatten(<<1,2,3>,<4,5,6>>,?flatlist))'
		description: 'Can we computed the flattened version of a nested list?'.
	self processQuery:
			' if succeeds(flatten(<<1,2,3>,<4,5,6>>,<1,2,3,4,5,6>))' description:
			'Is the flattened version of a nested list computed correctly?'.
	self processQuery:
			' if succeeds(and(flatten(<<[1],[2],[3]>,<[4],[5],[6]>>,?flatlist),equals(?flatlist,<[1],[2],[3],[4],[5],[6]>)))'
		description:
			'Does flatten/2 work correctly with second argument unbound?'.
	self processQuery:
			' if succeeds(flatten(<<1,<2>,3>,<<<4>,5>,6>>,<1,<2>,3,<<4>,5>,6>))'
		description:
			'Is the flattened version of a nested list computed correctly when the list is
					more than one level deep?'.
	self processQuery:
			' if succeeds(flatten(<<1,2,3>,<>,<a,b>,<c>,<>>,<1,2,3,a,b,c>))'
		description:
			'Does flatten work correctly when the list to be flattened contain empty sublists?'