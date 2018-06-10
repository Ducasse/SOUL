initialize-release
withClauses: aCollection
	
	| coll |
	nodeMapping := Dictionary new.
	clauseNames := Dictionary new.
	aCollection
		do:
			[:aClause | 
			| name |
			name := aClause conclusion functor asString
				, aClause conclusion multiplicity asString.
			coll := clauseNames
				at: name
				ifAbsent:
					[clauseNames
						at: name
						put: OrderedCollection new].
			coll add: aClause.
			nodeMapping
				at: aClause
				put: OrderedCollection new].
	self processClauses: aCollection