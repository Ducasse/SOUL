Public
runCase: aTestCase do: aBlock
	"a testcase is being run. Keep the result for the testCase's class"

	"a testcase is being run. Run the supplied block. As a result, the queries contained in the testcase will be run, and their totals collected in #ranQuery:description:. As a side-effect, the instance variable caseCount will remember the sum of all the timings of these queries. This is the time this case took to execute. As an alternative, we could also simply time the block, which would time the execution of the whole block, including writing the results, etc. While this is more general, the implementation only includes the time for executing without other overhead."

	
	self resetCaseCount.
	aBlock value.
	self
		keepTime: self caseCount
		forClass: aTestCase class