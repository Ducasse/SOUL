repository
addToRepository: aRep
	
	| var |
	self conclusion isCallTerm
		ifTrue:
			[var := self conclusion variable.
			aRep
				addCallClause: self asNormalClause
				for: var]
		ifFalse: [aRep addNormalClause: self]