soul auto saved
retractMatchM1

"retractMatch(+?Term) retracts all occurence of a clause of which the head unifies with ?Term"

retractMatch(&term) if 
	nonvar(&term),getRepository(?repository),getEnv(?env,?),envLookup(&term,?index),[| clauses result |
result := false.
clauses := ?repository
	clausesForKey: (&term predicateKeyInEnv: ?env startAt: nil)
	ifAbsent: [#()].
clauses
	do:
		[:aClause | 
		| i |
		i := ?env startUnifyWith: aClause.
		(&term
			unifyWith: aClause conclusion
			inEnv: ?env
			myIndex: ?index
			hisIndex: i
			inSource: true)
			ifTrue:
				[?repository removeClause: aClause.
				result := true].
		?env rollback].
result]