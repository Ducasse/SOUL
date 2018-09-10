the clause database
testassert1
	"self run:#testassert1"

	
	self processQuery: ' if assert(foo(foo(blabla))),foo(foo(blabla))'
		description: 'Does assert work properly for simple facts?'.
	self processQuery: ' if assert(foo([Object])),foo([Object])' description:
			'Does assert work properly for facts containing a simple smalltalkterm?'.
	self processQuery: ' if equals(?x,[Class]),assert(foo(?x)),foo([Class])'
		description:
			'Does assert work properly for facts containing a smalltalkterm with variables?'.
	self repository retractAll: 'foo/1'	"What about using assert/1 on logic rules? Which format to use?"