private
generateExistential: aDefinitionRepository
	
	| nproduct nreachBase nreachRecur somePaths failnpattern coll |
	nproduct := 'nproduct' , self identifier asString ,
			'(?phi, ?n1, ?a1, ?n2, ?a2, ?current, ?next, ?processedPath, ?differenceVariable, ?restPath, ?newDifferenceVariable, ?newRestPath) if ' , 
			'npattern' , self identifier asString ,
			'(?phi, ?a1, ?a2, ?current, ?next, ?n1, ?n2, ?processedPath, ?differenceVariable, ?restPath, ?newDifferenceVariable, ?newRestPath)'.
	failnpattern := 'npattern' , self identifier asString ,
			'(?phi, ?a1, ?a2, ?n1, ?n2, ?current, ?next, ?processedPath, ?differenceVariable, ?restPath, ?newDifferenceVariable, ?newRestPath) if !, [ false ]'.
	nreachBase := 'nreach' , self identifier asString ,
			'(?phi, ?n1,?p1, ?n1, ?p1, ?current, ?next, ?processedPath, ?differenceVariable, <>) if [true]'.
	nreachRecur := 'nreach' , self identifier asString ,
			'(?phi, ?n1,?p1, ?n2, ?p2, ?current, ?next, ?processedPath, ?differenceVariable, ?restPath) if ' , 
			'nproduct' , self identifier asString ,
			'(?phi, ?n1, ?p1, ?na, ?pa, ?current, ?next, ?processedPath, ?differenceVariable, ?restPath, ?newDifferenceVariable, ?newRestPath),' , 
			'nreach' , self identifier asString , '(?phi, ?na, ?pa, ?n2, ?p2, ?next, ?neext, ?processedPath, ?newDifferenceVariable, ?newRestPath)'.
	somePaths := '?phi somepath' , self identifier asString ,
			': ?startWorld endWorld: ?endWorld path: ?path if ' , 
			'nreach', self identifier asString , 
			'(?phi, ?startWorld,' , initialGoal goalId asString , ' , ?endWorld,' , 
			endGoal goalId asString, ', ?startWorld, ?next,', 
			'?differenceVariable, ?differenceVariable, ?path)'.
	coll := OrderedCollection with: nproduct with: nreachBase with:
			nreachRecur with: somePaths.
	coll add: failnpattern.
	coll
		do:
			[:rule | RegexTerm generateRule: rule definitionRepository: aDefinitionRepository]