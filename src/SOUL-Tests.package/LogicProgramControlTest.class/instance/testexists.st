meta programming
testexists
	"self run:#testexists"

	
	self processQuery: ' if exists(fact2(?x))' description:
			'Does exists/1 work if there is exactly one solution for the query?'.
	self processQuery: ' if exists(fact1(?x))' description:
			'Does exists/1 work if there are multiple solutions for the query?'.
	self processQuery: ' if not(exists(fact1(z)))' description:
			'Does exists/1 fail if there are no solutions for the query?'.
	self processQuery: ' if exists(fact1(a),fact1(a))' description:
			'Does exists/2 work if there is solution for the expression and the query?'.
	self processQuery: ' if exists(fact1(?x),member(?x,<a>))' description:
			'Does exists/2 work if there is solution for the expression and the query?'.
	self processQuery: ' if not(exists(fact1(?x),member(?x,<z>)))'
		description:
			'Does exists/2 fail if there is solution for the expression and not for the query?'.
	self processQuery: ' if not(exists(fact1(z),member(a,<a>)))' description:
			'Does exists/2 fail if there is no solution for the expression but there is one for the query?'.
	self processQuery: ' if not(exists(fact1(z),member(z,<a>)))' description:
			'Does exists/2 fail if there is no solution for the expression and for the query?'