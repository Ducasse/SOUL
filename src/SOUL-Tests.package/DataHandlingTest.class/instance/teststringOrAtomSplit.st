string handling
teststringOrAtomSplit
	"self run:#teststringOrAtomSplit"

	"stringOrAtomSplit/4"

	
	self processQuery:
			' if succeeds(stringOrAtomSplit(TesterDeTester,est,T,erDeTester))'
		description:
			'Does stringOrAtomSplit/4 work correctly with 4 instantiated arguments?'.
	self processQuery:
			' if succeeds(stringOrAtomSplit(TesterDeTester,est,TesterDeT,er))'
		description:
			'Does stringOrAtomSplit/4 work correctly with 4 instantiated arguments?'.
	self processQuery:
			' if succeeds(stringOrAtomSplit(TesterDeTester,est,?Before,?After))'
		description:
			'Does stringOrAtomSplit/4 work with last two arguments uninstantiated?'.
	self
		processQuery: ' if stringOrAtomSplit(TesterDeTester,est,?Before,?After)'
		resultsCheck: [:results | results size = 2]
		description:
			'Does stringOrAtomSplit/4 produce more than one result if necessary?'.
	self processQuery:
			' if succeeds(stringOrAtomSplit([''TesterDeTester''],[''est''],[''T''],[''erDeTester'']))'
		description:
			'Does stringOrAtomSplit/4 work correctly with 4 instantiated arguments?'.
	self processQuery:
			' if succeeds(stringOrAtomSplit([''TesterDeTester''],[''est''],[''TesterDeT''],[''er'']))'
		description:
			'Does stringOrAtomSplit/4 work correctly with 4 instantiated arguments?'.
	self processQuery:
			' if succeeds(stringOrAtomSplit([''TesterDeTester''],[''est''],?Before,?After))'
		description:
			'Does stringOrAtomSplit/4 work with last two arguments uninstantiated?'.
	self
		processQuery:
			' if stringOrAtomSplit([''TesterDeTester''],[''est''],?Before,?After)'
		resultsCheck: [:results | results size = 2]
		description:
			'Does stringOrAtomSplit/4 produce more than one result if necessary?'