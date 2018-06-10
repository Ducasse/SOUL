access
additionalClausesForDefinitionRepository
	
	| clauses |
	clauses := OrderedCollection new.
	condition terms
		do:
			[:term | 
			term additionalClausesForDefinitionRepository
				ifNotNil: [:c | clauses addAll: c]].
	^clauses