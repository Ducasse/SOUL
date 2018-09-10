sets of solutions
testfindall
	"self run:#testfindall"

	"findall/3"

	
	self processQuery:
			' if succeeds(and(findall(?x,member(?x,<a,b,c>),?L),length(?L,[3])))'
		description: 'Does findall generate a list of all results of some query?'.
	self processQuery: ' if succeeds(findall(?X,member(?X,<a,b,c>),<a,b,c>))'
		description: 'Does findall/3 produced the correct list of results?'.
	self processQuery: ' if fails(findall(?X,member(?X,<a,b,c>),<?>))'
		description:
			'Can findall/3 be used to test whether there is only one result of a query?'.
	self processQuery:
			' if succeeds(findall(?x,and(member(?x,<a,b,c>),integer(?x)),<>))'
		description:
			'Does findall generate an empty list when the tested query fails?'.
	self processQuery:
			' if succeeds(and(equals(?numbers,<[1],[2],[3]>),equals(?names,<a,b,c>),findall(pair(?x,?name),and(member(?x,?numbers),member(?name,?names)),?L),sameElements(?L,<pair([1],a),pair([2],a),pair([3],a),pair([1],b),pair([2],b),pair([3],b),pair([1],c),pair([2],c),pair([3],c)>)))'
		description:
			'Can findall be used to generate a  list of couples of solutions?'