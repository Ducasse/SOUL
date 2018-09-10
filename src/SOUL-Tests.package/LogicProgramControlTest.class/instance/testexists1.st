meta programming
testexists1
	"self run:#testexists1"

	"exists/1"

	
	self processQuery: ' if succeeds(exists(list(<>)))' description:
			'Does there exist an empty list?'.
	self processQuery: ' if fails(exists(list([1])))' description:
			'Does no solution exist to the query list([1])?'.
	self processQuery: ' if exists(member(1,<1,2,3>))' description:
			'Does there exists a member 1 in the list <1,2,3>?'.
	self processQuery: ' if exists(member(1,<2,1,3,1>))' description:
			'Does there exist a member 1 in a list containing multiple occurences of 1? (Note that this query is supposed to return one result only, because exists/1 is implemented lazily.)'.
	self processQuery: ' if exists(and(equals(?X,7),equals([7 + ?X],?Y)))'
		description:
			'Does exists/1 work when it contains a Smalltalk term containing a logic variable'