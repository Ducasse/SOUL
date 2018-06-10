private
generateUniversal: aDefinitionRepository
	
	| allPaths nproduct nreachBase nreachRecur failnpattern coll |
	self generateExistential: aDefinitionRepository.
	nproduct := 'nproductUniversal' , self identifier asString ,
			'(?phi, ?n1, ?a1, ?n2, ?a2) if ' , 'npatternUniversal'
		, self identifier asString , '(?phi, ?a1, ?a2, ?current, ?n1, ?n2)'.
	failnpattern := 'npatternUniversal' , self identifier asString ,
			'(?phi, ?a1, ?a2, ?current, ?n1, ?n2) if !, [ false ]'.
	nreachBase := 'nreachUniversal' , self identifier asString ,
			'(?phi, ?n1,?p1, ?n1, ?p1) if [true]'.
	nreachRecur := 'nreachUniversal' , self identifier asString ,
			'(?phi, ?n1,?p1, ?n2, ?p2) if ' , 'nproductUniversal'
		, self identifier asString , '(?phi, ?n1, ?p1, ?na, ?pa),' ,
			'nreachUniversal' , self identifier asString ,
			'(?phi, ?na, ?pa, ?n2, ?p2)'.
	allPaths := '?phi allpaths' , self identifier asString ,
			': ?startWorld endWorld: ?endWorld if ' , '?phi somepath'
		, self identifier asString , ': ?startWorld endWorld: ?endWorld,' ,
			'nreachUniversal' , self identifier asString , '(?phi, ?startWorld,'
		, initialGoal goalId asString , ' , ?endWorld,' , endGoal goalId asString
		, ')'.
	coll := OrderedCollection with: nproduct with: nreachBase with:
			nreachRecur with: allPaths.
	coll add: failnpattern.
	coll
		do:
			[:rule | RegexTerm generateRule: rule definitionRepository: aDefinitionRepository]