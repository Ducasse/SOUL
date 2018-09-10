string handling
testendsWith
	"self run: #testendsWith"

	"endsWith/2"

	
	self processQuery: ' if succeeds(endsWith([''aTest''],[''est'']))'
		description: 'Does a certain string end with a certain postfix?'.
	self processQuery: ' if succeeds(endsWith([''aTest''],st))' description:
			'Does a certain string end with a certain postfix?'.
	self processQuery: ' if succeeds(endsWith(aTest,[''Test'']))' description:
			'Does a certain string end with a certain postfix?'.
	self processQuery: ' if succeeds(endsWith(aTest,Test))' description:
			'Does a certain string end with a certain postfix?'.
	self processQuery: ' if succeeds(endsWith(aTest,aTest))' description:
			'Does a string have itself as postfix?'.
	self processQuery: ' if succeeds(endsWith(aTest,['''']))' description:
			'Does a certain string end with the empty postfix?'.
	self processQuery: ' if succeeds(endsWith(aTest,atest))' description:
			'Is the endsWith predicate case INsensitive?'.
	self processQuery: ' if succeeds(endsWith([''aTest''],[''atest'']))'
		description: 'Is the endsWith predicate case INsensitive?'