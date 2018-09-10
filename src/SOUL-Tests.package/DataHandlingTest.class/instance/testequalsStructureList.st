term conversion
testequalsStructureList
	"self run:#testequalsStructureList"

	"self debug:#testequalsStructureList"

	"equalsStructureList/2"

	
	self processQuery: ' if succeeds(equalsStructureList(foo(bar),?list))'
		description:
			'Does equalsStructureList/2 work when first argument is a fully instantiated compound term?'.
	self processQuery:
			' if succeeds(and(equalsStructureList(foo(bar),?list),equals(?list,<foo,bar>)))'
		description:
			'Does equalsStructureList/2 produced the correct result when first argument is a fully instantiated compound term?'.
	self processQuery: ' if succeeds(equalsStructureList(foo(bar),<foo,bar>))'
		description:
			'Does equalsStructureList/2 produced the correct result when first argument is a fully instantiated compound term?'.
	self processQuery: ' if succeeds(equalsStructureList(foo(?x),?list))'
		description:
			'Does equalsStructureList/2 work when first argument is a partially instantiated compound term?'.
	self processQuery: ' if succeeds(equalsStructureList(foo(?x),<foo,?x>))'
		description:
			'Does equalsStructureList/2 produced the correct result when first argument is a partially instantiated compound term?'.
	self processQuery: ' if succeeds(equalsStructureList(?x(?y),?list))'
		description:
			'Does equalsStructureList/2 work when first argument is a fully uninstantiated compound term?'.
	self processQuery: ' if succeeds(equalsStructureList(?x(?y),<?x,?y>))'
		description:
			'Does equalsStructureList/2 produced the correct result when first argument is a fully uninstantiated compound term?'.
	self processQuery: ' if succeeds(equalsStructureList(foo,?list))'
		description:
			'Does equalsStructureList/2 work when first argument is a non-compound term?'.
	self processQuery:
			' if succeeds(and(equalsStructureList(foo,?list),equals(?list,<foo>)))'
		description:
			'Does equalsStructureList/2 produce the correct result when first argument is a non-compound term?'.
	self processQuery: ' if succeeds(equalsStructureList(foo,<foo>))'
		description:
			'Does equalsStructureList/2 produce the correct result when first argument is a non-compound term?'.
	self processQuery: ' if fails(equalsStructureList(?x,?l))' description:
			'Does equalsStructureList/2 fails when both arguments are variable?'.
	self processQuery: ' if fails(equalsStructureList(?x,<?x>))' description:
			'Does equalsStructureList/2 fails when both arguments are variable?'.
	self processQuery: ' if fails(equalsStructureList(foo(bar),<foo(bar)>))'
		description:
			'Does equalsStructureList/2 not allow compound terms as keys?'.
	self processQuery:
			' if succeeds(equalsStructureList(foo(bar(a),zork(2),flur(e)),<foo|?More>))'
		description: 'Check correctness of equalsStructureList/2'.
	self processQuery:
			' if succeeds(and(equalsStructureList(foo(bar(a),zork(2),flur(e)),<foo|?More>),equals(?More,<bar(a),zork(2),flur(e)>)))'
		description: 'Check correctness of equalsStructureList/2'.
	self processQuery: ' if succeeds(equalsStructureList(?term,<foo,bar>))'
		description:
			'Does equalsStructureList/2 work when second argument is list with two bound arguments?'.
	self processQuery:
			' if succeeds(and(equalsStructureList(?term,<foo,bar>),equals(?term,foo(bar))))'
		description:
			'Does equalsStructureList/2 produce the correct result when second argument is list with two bound arguments?'.
	self processQuery:
			' if succeeds(and(equalsStructureList(?term,<foo,?y>),equals(?term,foo(?y))))'
		description: 'Check correctness of equalsStructureList/2'	"THESE CASES ARE NOT SUPPORTED YET...

	self	processQuery: 'if succeeds(and(equalsStructureList(?term,<?x,bar>),equals(?term,?x(bar))))'
		description: 'Check correctness of equalsStructureList/2'.

	self	processQuery: 'if succeeds(and(equalsStructureList(?term,<?x,?y>),equals(?term,?x(?y))))'
		description: 'Check correctness of equalsStructureList/2'
"