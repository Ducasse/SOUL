sets of solutions
testexactlyOne
	"self run:#testexactlyOne"

	"exactlyOne/1"

	
	self processQuery: ' if fails(exactlyOne(fact1(a)))' description:
			'Doe exactlyOne/1 called on a fact fail if there are 3 occurences of that fact?'.
	self processQuery: ' if fails(exactlyOne(fact1(b)))' description:
			'Doe exactlyOne/1 called on a fact fail if there are 2 occurences of that fact?'.
	self processQuery: ' if succeeds(exactlyOne(fact1(c)))' description:
			'Doe exactlyOne/1 called on a fact succeed if there is only 1 occurence of that fact?'.
	self processQuery: ' if fails(exactlyOne(fact1(d)))' description:
			'Doe exactlyOne/1 called on a fact fail if there are no occurences of that fact?'.
	self processQuery: ' if fails(exactlyOne(fact1(?X)))' description:
			'Doe exactlyOne/1 called on a query fail if there are multiple solutions of that query?'.
	self processQuery: ' if succeeds(exactlyOne(fact2(onlyOccurence)))'
		description:
			'Doe exactlyOne/1 called on a fact succeed if there is only 1 occurence of that fact?'.
	self processQuery: ' if succeeds(exactlyOne(fact2(?X)))' description:
			'Doe exactlyOne/1 called on a query succeed if there is only 1 solution to that query?'.
	self processQuery: ' if fails(exactlyOne(member(?X,<a,b,c,d>)))'
		description:
			'Doe exactlyOne/1 called on a query fail if there are many solutions to that query?'.
	self processQuery: ' if succeeds(exactlyOne(one(member(?X,<a,b,c,d>))))'
		description:
			'Doe exactlyOne/1 called on a query succeeds if there is at least one solution to that query, and the query is wrapped in a one/1 statement?'