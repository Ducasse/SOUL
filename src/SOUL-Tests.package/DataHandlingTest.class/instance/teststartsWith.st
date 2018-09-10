string handling
teststartsWith
	"test run:#teststartsWith"

	"startsWith/2"

	
	self processQuery: ' if succeeds(startsWith([''aTest''],[''a'']))'
		description: 'Does a certain string start with a certain prefix?'.
	self processQuery: ' if succeeds(startsWith([''aTest''],aT))' description:
			'Does a certain string start with a certain prefix?'.
	self processQuery: ' if succeeds(startsWith(aTest,[''aTe'']))'
		description: 'Does a certain string start with a certain prefix?'.
	self processQuery: ' if succeeds(startsWith(aTest,aTes))' description:
			'Does a certain string start with a certain prefix?'.
	self processQuery: ' if succeeds(startsWith(aTest,aTest))' description:
			'Does a certain string start with a certain prefix?'.
	self processQuery: ' if succeeds(startsWith(aTest,['''']))' description:
			'Does a certain string start with a certain prefix?'.
	self processQuery: ' if succeeds(startsWith(aTest,atest))' description:
			'Is the startsWith predicate case INsensitive?'.
	self processQuery: ' if succeeds(startsWith([''aTest''],[''atest'']))'
		description: 'Is the startsWith predicate case INsensitive?'