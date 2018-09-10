string handling
testmakeFirstCapitalLowerCase
	"self run: #testmakeFirstCapitalLowerCase"

	"makeFirstCapitalLowerCase/2"

	
	self processQuery:
			' if succeeds(makeFirstCapitalLowerCase([''Test''],[''test'']))'
		description: 'Transform first capital into lowercase'.
	self processQuery:
			' if succeeds(makeFirstCapitalLowerCase([''test''],[''test'']))'
		description: 'Does it work if first is already lowercase?'.
	self processQuery:
			' if succeeds(and(makeFirstCapitalLowerCase([''Test''],?x),equals(?x,[''test''])))'
		description: 'Does it work when second argument is variable?'