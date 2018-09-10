parser-printer
testPrintAndParse
	"This does a sanity test of the printer and parser: the given expression is first parsed, and then printed. Then the printed version is again parsed and printed. The two prints should be exactly the same. Note that this is a necessary but not sufficient condition for the print to be correct, since printing everything to the string 'dummy' would also satisfy this test."

	
	self assertExpressionPrintsAndParsesSanely: 'abc'.
	self assertExpressionPrintsAndParsesSanely: '1'.
	self assertExpressionPrintsAndParsesSanely: '<>'.
	self assertExpressionPrintsAndParsesSanely: 'Abc'.
	self assertExpressionPrintsAndParsesSanely: '?x'.
	self assertExpressionPrintsAndParsesSanely: '[ 1 ]'.
	self assertExpressionPrintsAndParsesSanely: 'a(1,2)'.
	self assertExpressionPrintsAndParsesSanely: '[ 1 + ?x ]'.
	self assertExpressionPrintsAndParsesSanely: '<1,2,3>'.
	self assertExpressionPrintsAndParsesSanely: '<1,2|3>'.
	self assertExpressionPrintsAndParsesSanely: '<1,2,3|<>>'.
	self assertExpressionPrintsAndParsesSanely: '<1,2|<3>>'.
	self assertExpressionPrintsAndParsesSanely: '<?x|?y>'.
	self assertExpressionPrintsAndParsesSanely: '<?x|<?y>>'.
	self assertExpressionPrintsAndParsesSanely: 'a(1) if b(2)'.
	self assertExpressionPrintsAndParsesSanely:
			'a(1,2,3) if b(4,5,6), c(7,8,9)'.
	self assertExpressionPrintsAndParsesSanely:
			'a( 1, 2 ,3  ) if b( 4,5,6 ), c(7 , 8 , 9)'