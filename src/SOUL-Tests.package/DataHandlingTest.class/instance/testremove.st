list handling
testremove
	"remove/3"

	
	self processQuery:
			' if succeeds(remove(<[1],[2],[3],[4],[5]>,[4],<[1],[2],[3],[5]>))'
		description: 'Remove an element from a list'.
	self processQuery: ' if succeeds(remove(<1,2,3,4,5>,4,?L))' description:
			'Remove an element from a list'.
	self processQuery:
			' if succeeds(and(remove(<1,2,3,4,5>,4,?L),equals(?L,<1,2,3,5>)))'
		description: 'Remove an element from a list'.
	self
		processQuery: ' if remove(<1,2,3,2,1>,1,?L)'
		resultsCheck: [:results | results size = 1]
		description: 'Only first occurence is removed'.
	self processQuery: ' if fails(remove(<1,2,3,2,1>,1,<1,2,3,2>))'
		description: 'Only first occurence is removed'.
	self processQuery: ' if succeeds(remove(<1,2,3,2,1>,?X,?L))' description:
			'Remove some element from some list.'.
	self processQuery: ' if succeeds(remove(?L,4,<a,b,c>))' description:
			'Remove can also be called with first argument variable.'.
	self
		processQuery: ' if remove(?L,4,<a,b,c>)'
		resultsCheck: [:results | results size = 4]
		description:
			'There are 4 ways to re-insert an element in a list of size 3'