errors
testerror
	"self run:#testerror"

	"Normally, one would do:
		self should: [query allResults] raise: Error
	But I wanted to check the error message as well, so I do this more extensive version."

	
	| query |
	query := SoulFactory current evaluatorForLogicQuery
		eval: 'if error([''Error for the SUnit testcase''])'
		in: self repository.
	[query allResults]
		on: SoulRuntimeException
		do:
			[:exc | self assert: exc messageText = 'SOUL >> Error for the SUnit testcase']