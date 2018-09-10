string handling
teststringSplit
	"self run:#teststringSplit"

	"stringSplit/4"

	
	self processQuery:
			' if succeeds(stringSplit([''TesterDeTester''],[''est''],[''T''],[''erDeTester'']))'
		description:
			'Does stringSplit/4 work correctly with 4 instantiated arguments?'.
	self processQuery:
			' if succeeds(stringSplit([''TesterDeTester''],[''est''],[''TesterDeT''],[''er'']))'
		description:
			'Does stringSplit/4 work correctly with 4 instantiated arguments?'.
	self processQuery:
			' if succeeds(stringSplit([''TesterDeTester''],[''est''],?Before,?After))'
		description:
			'Does stringSplit/4 work with last two arguments uninstantiated?'.
	self
		processQuery:
			' if stringSplit([''TesterDeTester''],[''est''],?Before,?After)'
		resultsCheck: [:results | results size = 2]
		description:
			'Does stringSplit/4 produce more than one result if necessary?'