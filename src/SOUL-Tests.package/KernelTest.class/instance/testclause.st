natives
testclause
	
	self processQuery: ' if clause(equals(?a,?b),?body),equals(?body,<>)'
		description: 'Does the clause predicate give an empty body for a fact?'.
	self processQuery: ' if clause(?head,<>),equals(?head,equals(?z,?z))'
		description: 'Is equals(?z,?z) one of the facts in the repository?'.
	self processQuery:
			' if clause(?head,<not(equals(?a,?b))>),equals(?head,differs(?a,?b))'
		description:
			'Is the rule with the body not(equals(?a, ?b)) the one for the predicate differs?'.
	self processQuery:
			' if clause(equals(?avar,[?unboundVar someMessage]),?body)' description:
			'Does clause work correctly when the head contains a compound term with a smalltalk term in it?'