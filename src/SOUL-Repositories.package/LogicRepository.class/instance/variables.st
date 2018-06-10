repository composition
variables
	
	| visitor |
	visitor := RepositoryVariableAccVisitor new.
	self compile.
	1
		to: currentAddress
		do:
			[:index | 
			(clauseArray at: index)
				do:
					[:cl | cl == nil ifFalse: [cl do: [:clause | clause accept: visitor]]]].
	^visitor variables