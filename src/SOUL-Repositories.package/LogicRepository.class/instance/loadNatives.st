natives
loadNatives
	
	| natives |
	"The repository automatically contains a set of native predicates that can be used in Soul programs"

	natives := OrderedCollection new.
	natives
		add:
			(self
				makeNative: 'writeToProlog(?x)'
				if: SoulFactory current makeWriteToPrologClause).
	natives
		add:
			(self
				makeNative: 'getEnv(?var,?idx)'
				if: SoulFactory current makeGetEnvClause).
	natives
		add:
			(self
				makeNative: 'getRepository(?var)'
				if: SoulFactory current makeGetRepositoryClause).
	natives
		add:
			(self
				makeNative: 'setResolver(?block,?args)'
				if: SoulFactory current makeSetResolverClause).
	natives
		add:
			(self
				makeNative: 'not@(?clauses)'
				if: SoulFactory current makeNotClause).
	natives
		add:
			(self
				makeNative: 'or@(?clauses)'
				if: SoulFactory current makeOrClause).
	natives
		add:
			(self
				makeNative: 'and@(?clauses)'
				if: SoulFactory current makeAndClause).
	natives
		add:
			(self
				makeNative: 'envLookup(&term,?termApp)'
				if: SoulFactory current makeEnvLookupClause).
	natives
		add:
			(self
				makeNative: 'clause(&head,&body,?clause)'
				if: SoulFactory current makeClauseClause).
	self addProgram: (ProgramSequence clauses: natives)