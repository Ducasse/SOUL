resolving
lexicalAddressInEnv: anEnv startAt: anIndex repository: aRep ifAbsent: aBlock
	"Lookup the address of the predicate of this clause in the database"

	
	| addr index |
	addr := self lexicalAddress.
	^addr
		ifNil:
			[index := aRep
				addressForPredicate: (self predicateInEnv: anEnv startAt: anIndex).
			index
				ifNil: aBlock
				ifNotNil: [index]]
		ifNotNil: [addr]