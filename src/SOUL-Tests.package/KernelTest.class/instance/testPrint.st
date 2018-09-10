parser-printer
testPrint
	"This is a more strict test than the one performed by the sanity test testPrintAndParse. Unlike the sanity test, it really tests that the printer and parser are correct for these expressions and not just sane, but this test is sensitive to small changes in the printer (such as adding extra irrelevant spacing)"

	
	self should: '1' printAs: '1'.
	self should: 'abc' printAs: 'abc'.
	self should: '<1>' printAs: '<1>'.
	self should: '<?x>' printAs: '<?x>'.
	self should: '<1,2>' printAs: '<1,2>'.
	self should: '<1, 2>' printAs: '<1,2>'.
	self should: '< [1], [2] >' printAs: '<[1],[2]>'.
	self should: '<1,2|3>' printAs: '<1,2|3>'.
	self should: '<1,2|<3>>' printAs: '<1,2,3>'.
	self should: '<?x|?y>' printAs: '<?x|?y>'.
	self should: '<?x,?y>' printAs: '<?x,?y>'.
	self should: '<<?x>|<?y>>' printAs: '<<?x>,?y>'.
	self should: '<<?x>|?y>' printAs: '<<?x>|?y>'.
	self should: 'abc(1,2,3)' printAs: 'abc(1,2,3)'.
	self
		should: 'abc(1,xyz(2,2),3) if defg([#cat],[#dog]), hij([?x + ?y])'
		printAs:
			'abc(1,xyz(2,2),3) if '
				,
					(String
						with: Character cr
						with: Character tab) , 'defg([#cat],[#dog]),hij([?x + ?y])'