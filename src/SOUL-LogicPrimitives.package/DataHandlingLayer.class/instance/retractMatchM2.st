soul auto saved
retractMatchM2

"retractMatch(+?Term,+?conditionPredicate) retracts all occurence of a clause of which the head unifies with ?Term"

retractMatch(&term,&conditionPredicate) if 
	nonvar(&term),nonvar(&conditionPredicate),getRepository(?repository),getEnv(?env,?),envLookup(&term,?termPointer),collectionMember(?clause,[| clauses result i |
result := OrderedCollection new.
clauses := ?repository
	clausesForKey: (&term predicateKeyInEnv: ?env startAt: nil)
	ifAbsent: [#()].
clauses
	do:
		[:aClause | 
		i := ?env startUnifyWith: aClause.
		(?termPointer term
			unifyWith: aClause conclusion
			inEnv: ?env
			myIndex: ?termPointer envIndex
			hisIndex: i
			inSource: true) ifTrue: [result add: aClause].
		?env rollback].
result]),apply(&conditionPredicate,<?clause>),[?repository removeClause: ?clause]