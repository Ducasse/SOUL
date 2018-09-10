list handling
testtail
	"tail/2"

	
	self processQuery: ' if succeeds(tail(<b,c>,<a,b,c>))' description:
			'Does tail/2 work correctly?'.
	self processQuery: ' if succeeds(tail(<c>,<b,c>))' description:
			'Does tail/2 work correctly?'.
	self processQuery: ' if succeeds(tail(<>,<c>))' description:
			'Does tail/2 work correctly?'.
	self processQuery: ' if succeeds(tail(?x,<a,b,c>))' description:
			'Does tail/2 work when first argument is unbound?'.
	self processQuery: ' if succeeds(and(tail(?x,<a,b,c>),equals(?x,<b,c>)))'
		description: 'Does tail/2 work correctly when first argument is unbound?'.
	self processQuery: ' if succeeds(tail(?x,<a|?y>))' description:
			'Does tail/2 work when rest of list is variable?'.
	self processQuery: ' if succeeds(and(tail(?x,<a|?y>),equals(?x,?y)))'
		description: 'Does tail/2 work correctly when rest of list is variable?'.
	self processQuery: ' if succeeds(tail(?x,<a|?x>))' description:
			'Does tail/2 work correctly when rest of list is variable?'.
	self processQuery: ' if fails(tail(?x,<>))' description:
			'Does the empty list have no tail?'