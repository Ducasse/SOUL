the clause database
testassert2
	"self run:#testassert2"

	
	self processQuery: ' if getRepository(?rep),assert(foo(x)),foo(x)'
		description:
			'Check if the assert can assert a clause in the repository when it is given as a parameter'.
	self repository retractAll: 'foo/1'