soul auto saved
assertM1

"assert(+?Term) asserts a clause (i.e., a fact or rule) that is given as a logic ?Term"

assert(&term) if 
	getRepository(?repository),getEnv(?env,?),[?repository
	addClause:
		(Fact
			condition:
				(SoulFactory current makeTermSequence terms: OrderedCollection new)
			conclusion: &term)]