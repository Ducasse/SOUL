natives
retractNatives
	
	self
		clausesDo:
			[:clause | 
			| conditions |
			clause notNil
				ifTrue:
					["I encountered nil-clauses, this does not seem correct."

					conditions := clause condition terms.
					(conditions size >= 1 and: [conditions first isKindOf: NativeClause])
						ifTrue: [self removeClause: clause]]]