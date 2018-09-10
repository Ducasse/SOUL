repositories
testScoping
	
	| repA repB |
	repA := SoulFactory current makeRepository new.
	repA compilationFactory: (SoulFactory current).
	repB := SoulFactory current makeRepository new.
	repB compilationFactory: (SoulFactory current).
	repA assert: 'fact(a)'.
	repA assert: 'equals(?x,?x)'.
	repA assert: '?b->fact(c)'.
	repA assert: '?b->fact(d) if fact(a)'.
	repB assert: 'fact(b)'.
	repA
		bind: (Variable name: 'b')
		with: repB.
	self processQuery: ' if fact(?x),equals(?x,a)' description:
			'Does the repository with bindings work as normal?' repository: repA.
	self processQuery: ' if ?b->fact(?x),equals(?x,b)' description:
			'Does the repository lookup work correctly?' repository: repA.
	self processQuery: ' if ?b->fact(d)' description:
			'Does the repository lookup work correctly?' repository: repA.
	self processQuery: ' if fact(b),fact(c)' description:
			'Does the repository addition work correctly?' repository: repB.
	self class testRepository: repB.
	[self processQuery:
			' if equals(?rep,[KernelTest testRepository]),?rep->fact(b)'
		description:
			'Does the lookup mechanism first consider looking in the local environment?'
		repository: repA] ensure: [self class testRepository: nil]