converting
asPredicateNameInEnv: anEnv startAt: anIndex
	"When this terms is used as a predicate (functor), generate its representation as a predicatename. The default behaviour generates an error"

	
	self error: 'The term ' , self asString , ' cannot be used as a predicate'