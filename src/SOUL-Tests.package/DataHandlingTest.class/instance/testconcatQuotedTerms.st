quoted term handling
testconcatQuotedTerms
	"self run:#testconcatQuotedTerms"

	"concatQuotedTerms/3"

	
	self processQuery: ' if succeeds(concatQuotedTerms(<>,{ },{}))'
		description:
			'Is the empty list converted in an empty quoted code term (regardless of the separator)?'.
	self processQuery: ' if succeeds(concatQuotedTerms(<{foo}>,{ },{foo}))'
		description:
			'Is a single quoted code term converted into itself (regardless of the separator)?'.
	self processQuery:
			' if succeeds(and(concatQuotedTerms(<{foo},{bar}>,{ },?result),equals(?result,{foo bar})))'
		description:
			'Is a list of two quoted code terms converted into a quoted code term containing those two quoted code terms with a space in between (when the separator is a space)?'.
	self processQuery:
			' if succeeds(and(concatQuotedTerms(<{foo},{bar},{zork}>,{ },?result),equals(?result,{foo bar zork})))'
		description:
			'Is a list of three quoted code terms converted into a quoted code term containing those three quoted code terms with a space between each two (when the separator is a space)?'