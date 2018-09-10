Test Interface
afterCaseDo: aTestCase
	"a testcase was run. As a result, the queries contained in the testcasewere run, and their totals collected in #ranQuery:description:. As a side-effect, the instance variable caseCount remembered the sum of all the timings of these queries. Remember the result here."

	
	self
		keepTime: self caseCount
		forClass: aTestCase class.
	self
		output: aTestCase selector printString
		took: self caseCount