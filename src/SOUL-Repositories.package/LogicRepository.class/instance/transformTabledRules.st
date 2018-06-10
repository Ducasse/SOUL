prepare for use
transformTabledRules
	
	| newRules |
	"we generate the new rules"

	newRules := TabledRule transformTabledRules: tabledRules withCallGraph:
			callGraph.	"we remove the old tabled rules as they are not needed in the resolution. All the transformed rules are in newRules"

	tabledRules
		do:
			[:aTabledRule | self removeClause: aTabledRule cleanupGenerated: false].	"we add the newly generated rules to the repo"

	newRules do: [:aRule | self addClause: aRule].	"should probably be in seperate method"

	SLGCall initializeQueries