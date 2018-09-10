Test Interface
beforeCaseDo: aTestCase
	"a testcase will be run. As a result, the queries contained in the testcase will be run, and their totals collected in #ranQuery:description:. As a side-effect, the instance variable caseCount will remember the sum of all the timings of these queries. This total is reset here."

	
	self resetCaseCount