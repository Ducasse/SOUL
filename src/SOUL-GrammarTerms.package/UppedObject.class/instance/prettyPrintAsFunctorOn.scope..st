printing
prettyPrintAsFunctorOn: aStream scope: id
	
	id = #asClause
		ifTrue:
			[aStream withAttribute:(TextEmphasis bold) do:[aStream write: smalltalkValue asString]] ifFalse:[aStream write: smalltalkValue asString.]