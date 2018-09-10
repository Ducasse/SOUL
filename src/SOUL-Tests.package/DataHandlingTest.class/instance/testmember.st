list handling
testmember
	"member/2"

	
	self processQuery: ' if succeeds(member(a,<a,b,c>))' description:
			'Does the list <a,b,c> contain a?'.
	self processQuery: ' if succeeds(member(b,<a,b,c>))' description:
			'Does the list <a,b,c> contain b?'.
	self processQuery: ' if fails(member(d,<a,b,c>))' description:
			'Does the list <a,b,c> not contain d?'.
	self processQuery: ' if succeeds(member(p(b),<p(a),q,3,p(b),p(b)>))'
		description: 'Does member/2 work for compound terms?'.
	self
		processQuery: ' if member(?X,<a,b,c>)'
		resultsCheck: [:results | results size = 3]
		description: 'Does the list <a,b,c> contain 3 elements?'.
	self
		processQuery: ' if member(?X,<a,?b,c>)'
		resultsCheck: [:results | results size = 3]
		description:
			'Does member work correctly with lists containing variables?'.
	self processQuery: ' if succeeds(member(a,?L))' description:
			'Does member/2 work when the list is variable?'.
	self processQuery: ' if succeeds(and(member(a,?L),equals(?L,<a|?Rest>)))'
		description:
			'When member/2 is called with a variable list, does it generate a list with the element in it?'.
	self
		processQuery: ' if member(p(?X),<p(a),p(b),p(c)>)'
		resultsCheck: [:results | results size = 3]
		description: 'Does the list <p(a),p(b),p(c)> contain 3 elements?'.
	self processQuery: ' if fails(member(?X,?L))' description:
			'Does the predicate fail when called with two variables?'