private
allClausesAt: anAddress
	
	| multArray resultClauses clauses |
	"return all clauses at the address"

	multArray := clauseArray at: anAddress.
	resultClauses := OrderedCollection new.
	multArray == nil ifTrue: [^resultClauses].
	(1 to: multArray size)
		do:
			[:index | 
			clauses := multArray at: index.
			clauses == nil ifFalse: [resultClauses addAll: clauses]].
	^resultClauses