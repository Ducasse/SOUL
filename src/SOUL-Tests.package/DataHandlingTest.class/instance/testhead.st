list handling
testhead
	"head/2"

	
	self processQuery: ' if succeeds(head(a,<a,b,c>))' description:
			'Does head/2 work correctly?'.
	self processQuery: ' if succeeds(head(?x,<a,b,c>))' description:
			'Does head/2 work when first argument is unbound?'.
	self processQuery: ' if succeeds(and(head(?x,<a,b,c>),equals(?x,a)))'
		description: 'Does head/2 work correctly when first argument is unbound?'.
	self processQuery: ' if succeeds(head(a,<?x,b,c>))' description:
			'Does head/2 work when first element of list is variable?'.
	self processQuery: ' if succeeds(and(head(a,<?x,b,c>),equals(?x,a)))'
		description:
			'Does head/2 work correctly when first element of list is variable?'.
	self processQuery: ' if succeeds(head(?y,<?x,b,c>))' description:
			'Does head/2 work when first element of list is variable?'.
	self processQuery: ' if succeeds(and(head(?y,<?x,b,c>),equals(?x,?y)))'
		description: 'Does head/2 work when first element of list is variable?'.
	self processQuery: ' if fails(head(?x,<>))' description:
			'Does the empty list have no head?'