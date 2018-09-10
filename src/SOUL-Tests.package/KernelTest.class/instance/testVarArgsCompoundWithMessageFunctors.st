evaluator
testVarArgsCompoundWithMessageFunctors
	
	self
		processQuery: ' if equals(#foo:@(?args), ?x foo: ?y)'
		description:
			'Binary message functors unify with variable argument compound terms (direct functor symbol).'
		repository: self repository.
	self
		processQuery:
			' if ?functor equals: #foo:,equals(?functor@(?args),?x foo: ?y)'
		description:
			'Binary message functors unify with variable argument compound terms (indirect functor symbol).'
		repository: self repository.
	self
		processQuery:
			' if ?functor equals: #foo:bar:,equals(?functor@(?args),?x foo: ?y bar: ?z)'
		description:
			'Non-unary message functors unify with variable argument compound terms (indirect functor symbol).'
		repository: self repository.
	self
		processQuery: ' if equals(isFoo@(?args),?x isFoo)'
		description:
			'Unary message functors unify with variable argument compound terms (direct functor symbol).'
		repository: self repository.
	self
		processQuery:
			' if ?functor equals: isFoo,equals(?functor@(?args),?x isFoo)'
		description:
			'Unary message functors unify with variable argument compound terms (indirect functor symbol).'
		repository: self repository