converting
asPredicateNameInEnv: anEnv startAt: anIndex
	
	| val |
	"see comment in AbstractTerm"

	val := anEnv lookup: self startAt: anIndex.
	^val isNil
		ifTrue:
			[self error: 'Trying to resolve a term with an unbound variable as functor']
		ifFalse:
			[val term
				asPredicateNameInEnv: anEnv
				startAt: val envIndex]