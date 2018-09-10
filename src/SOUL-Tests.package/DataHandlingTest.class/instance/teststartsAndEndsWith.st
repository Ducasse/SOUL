string handling
teststartsAndEndsWith
	"self run:#teststartsAndEndsWith"

	"startsAndEndsWith/3"

	
	self processQuery:
			' if succeeds(startsAndEndsWith([''aTest''],[''a''],[''Test'']))'
		description: 'Does a certain string start and end with given substrings?'.
	self processQuery:
			' if succeeds(startsAndEndsWith([''aTest''],[''a''],?End))' description:
			'Does a certain string start with a certain prefix?'.
	self processQuery:
			' if succeeds(and(startsAndEndsWith([''aTest''],[''a''],?End),equals(?End,[''Test''])))'
		description:
			'Does a certain string start with a certain prefix and is the
		remainder of the string computed correctly?'.
	self processQuery: ' if succeeds(startsAndEndsWith(aTest,aTes,?E))'
		description: 'Does a certain string start with a certain prefix?'.
	self processQuery: ' if succeeds(startsAndEndsWith(aTest,aTest,[#'''']))'
		description: 'Does a certain string start with a certain prefix?'.
	self processQuery: ' if succeeds(startsAndEndsWith(aTest,[#''''],aTest))'
		description: 'Does a certain string start with a certain prefix?'.
	self processQuery: ' if succeeds(startsAndEndsWith(aTest,ate,?E))'
		description:
			'Is the startsAndEndsWith predicate case INsensitive on second argument?'.
	self processQuery: ' if fails(startsAndEndsWith(aTest,aTe,sT))'
		description:
			'Is the startsAndEndsWith predicate case SENSITIVE on third argument?'