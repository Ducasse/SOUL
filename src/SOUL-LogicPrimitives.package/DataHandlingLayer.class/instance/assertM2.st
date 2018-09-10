soul auto saved
assertM2

"assert(+?Term,+?Repository) asserts a clause (i.e., a fact or rule) that is given as a logic ?Term
	 in a certain logic ?Repository"

assert(&term,?aRepository) if 
	getEnv(?env,?),[?aRepository
	addClause:
		(Fact
			condition:
				(SoulFactory current makeTermSequence terms: OrderedCollection new)
			conclusion: &term)]