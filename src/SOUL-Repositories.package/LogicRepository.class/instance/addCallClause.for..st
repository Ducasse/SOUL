add/del - runtime
addCallClause: aClause for: aVariable
	
	| coll |
	"callback from the clause to add a clause with a callterm as conclusion to the repository"

	aClause makeClean.
	aClause definitionRepository: self.
	coll := exports
		at: aVariable name
		ifAbsentPut: [OrderedCollection new].
	coll add: aClause