testing
testBasicTransformations
	
	| tabledRules generated callGraph |
	SoulFactory resetSLGTables.
	tabledRules := OrderedCollection new.
	tabledRules
		addAll:
			(SoulParser parse:
					'tabled tabledpath(?x,?y) if 
			tabledpath(?x,?z),edge(?z,?y).
		tabled tabledpath(?x,?y) if 
			edge(?x,?y)') clauses.
	callGraph := CallGraph withClauses: tabledRules.
	generated := TabledRule transformTabledRules: tabledRules withCallGraph:
			callGraph.
	self
		assert:
			(generated
				contains:
					[:rule | 
					(rule asString reject: [:x | x = Character cr]) matchesRegex:
							'tabledpath\(\?x,\?y\)\s+if\s+\s*\s*slg\(tabledpath\(\?x,\?y\)\)']).
	self
		assert:
			(generated
				contains:
					[:rule | 
					(rule asString reject: [:x | x = Character cr]) matchesRegex:
							'slgtabledpath\(\?Id,\?x,\?y\)\s+if\s+slgcall\(\?Id,<\?x,\?y>,tabledpath\(\?x,\?z\),\s*\[.*\]\s*,\s*cont0tabledpath\)']).
	self
		assert:
			(generated
				contains:
					[:rule | 
					(rule asString reject: [:x | x = Character cr]) matchesRegex:
							'cont0tabledpath\(\?Id,<\?x,\?y>,tabledpath\(\?x,\?z\),\?D\)\s+if\s+edge\(\?z,\?y\),\s*answer\(\?Id,tabledpath\(\?x,\?y\),\?D\)']).
	self
		assert:
			(generated
				contains:
					[:rule | 
					(rule asString reject: [:x | x = Character cr]) matchesRegex:
							'slgtabledpath\(\?Id,\?x,\?y\)\s+if\s+edge\(\?x,\?y\),\s*answer\(\?Id,tabledpath\(\?x,\?y\),\[.*\]\)'])