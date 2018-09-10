testing
testNotTransformations
	
	| tabledRules generated callGraph |
	SoulFactory resetSLGTables.
	tabledRules := OrderedCollection new.
	tabledRules
		addAll:
			(SoulParser parse:
					'tabled tabledpath(?x,?y) if 
			tabledpath(?x,?z),edge(?z,?y).
		tabled tabledpath(?x,?y) if 
			edge(?x,?y).
		tabled diff(?N) if 
			tabledpath(a,?N),not(tabledpath(c,?N))') clauses.
	callGraph := CallGraph withClauses: tabledRules.
	generated := (tabledRules at: 3) slgTransformWith: tabledRules
		withCallGraph: callGraph.
	self
		assert:
			(generated
				contains:
					[:rule | 
					(rule asString reject: [:x | x = Character cr]) matchesRegex:
							'slgdiff\(\?Id,\?N\)\s+if\s+slgcall\(\?Id,<\?N>,tabledpath\(a,\?N\),\[.*\],cont0diff\)']).
	self
		assert:
			(generated
				contains:
					[:rule | 
					(rule asString reject: [:x | x = Character cr]) matchesRegex:
							'cont0diff\(\?Id,<\?N>,tabledpath\(a,\?N\),\?D\)\s+if\s+slgnot\(\?Id,<\?N>,tabledpath\(c,\?N\),\[.*\],cont1diff\)']).
	self
		assert:
			(generated
				contains:
					[:rule | 
					(rule asString reject: [:x | x = Character cr]) matchesRegex:
							'cont1diff\(\?Id,<\?N>,\?D\)\s+if\s+answer\(\?Id,diff\(\?N\),\?D\)'])