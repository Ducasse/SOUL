private
isConnected: aTerm withClause: aClause
	
	| res termString clausesImplementingTerm |
	termString := aTerm functor asString , aTerm multiplicity asString.
	res := OrderedCollection new.
	clausesImplementingTerm := clauseNames
		at: termString
		ifAbsent: [^res].
	clausesImplementingTerm
		do:
			[:theClause | 
			(self
				isClauseConnected: theClause
				with: aClause
				visited: OrderedCollection new) ifTrue: [res add: theClause]].
	^res