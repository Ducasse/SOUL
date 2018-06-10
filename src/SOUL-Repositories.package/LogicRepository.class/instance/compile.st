prepare for use
compile
	"Compile the clauses in this repository if the changed flag indicates that it is no longer in sync with the storage"
	^self compileForced: additionalClauses isEmpty not