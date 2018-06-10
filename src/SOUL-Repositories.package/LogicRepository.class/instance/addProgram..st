add/del - runtime
addProgram: aProgram
	
	| clauses |
	"Add a Soul program to the database"

	clauses := aProgram clauses.
	clauses do: [:cl | self addClause: cl]