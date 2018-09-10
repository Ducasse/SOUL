Private
runCaseSelectorTimed
	"like the general runcase, but timed"

	
	self setUp.
	[self resetTotal.
	self perform: testSelector sunitAsSymbol.
	Transcript
		show: testSelector;
		show: ': took ';
		print: self currentTotal;
		show: ' ms';
		cr] sunitEnsure: [self tearDown]