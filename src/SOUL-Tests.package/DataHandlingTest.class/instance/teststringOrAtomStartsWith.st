string handling
teststringOrAtomStartsWith
	"self run:#teststringOrAtomStartsWith"

	"stringOrAtomStartsWith/2"

	
	self processQuery:
			' if succeeds(stringOrAtomStartsWith([''aTest''],[''a''],[''Test'']))'
		description: 'Does a certain string start and end with given substrings?'.
	self processQuery:
			' if succeeds(stringOrAtomStartsWith([''aTest''],[''a''],?End))'
		description: 'Does a certain string start with a certain prefix?'.
	self processQuery:
			' if succeeds(and(stringOrAtomStartsWith([''aTest''],[''a''],?End),equals(?End,[''Test''])))'
		description:
			'Does a certain string start with a certain prefix and is the
		remainder of the string computed correctly?'.
	self processQuery: ' if succeeds(stringOrAtomStartsWith(aTest,aTes,?E))'
		description: 'Does a certain atom start with a certain atom as prefix?'.
	self processQuery:
			' if succeeds(stringOrAtomStartsWith(aTest,aTest,[#'''']))' description:
			'Does a certain atom start with a certain atom as prefix?'.
	self processQuery:
			' if succeeds(stringOrAtomStartsWith(aTest,[#''''],aTest))' description:
			'Does a certain string or atom start with a certain prefix?'.
	self processQuery: ' if succeeds(stringOrAtomStartsWith(aTest,ate,?E))'
		description:
			'Is the stringOrAtomStartsWith predicate case INsensitive on second argument?'.
	self processQuery: ' if fails(stringOrAtomStartsWith(aTest,aTe,sT))'
		description:
			'Is the stringOrAtomStartsWith predicate case SENSITIVE on third argument?'