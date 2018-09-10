parser-printer
testPrintAndParseExtensively
	"This does the same sanity test as 'testPrintAndParse' but for all the clauses in LogicStorage."

	
	LogicStorage allClauses
		do: [:clause | self assertRepresentationPrintsAndParsesSanely: clause]