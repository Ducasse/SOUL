meta programming
testone
	"self run:#testone"

	"one/1"

	
	self processQuery: ' if succeeds(one(list(<>)))' description:
			'Does there exist exactly one empty list?'.
	self processQuery: ' if fails(one(list([1])))' description:
			'Is a number not a list?'.
	self
		processQuery: ' if one(and(member(?x,<1,2,3>),equals(?x,1)))'
		resultsCheck: [:results | results size = 1]
		description:
			'Retrieve exactly one item of a certain value from some list?'.
	self
		processQuery: ' if one(and(member(?x,<2,1,3,1>),equals(?x,1)))'
		resultsCheck: [:results | results size = 1]
		description:
			'Retrieve exactly one item of a certain value from some list, where the list is allowed to contain duplicates of that value?'.
	self processQuery:
			' if succeeds(findall(?X,one(member(1,<2,1,3,1>)),<?One>))' description:
			'Does findall/3 produced a singleton list, when the tested predicate is wrapped in a one/1 statement?'.
	self processQuery: ' if one(and(equals(?X,7),equals([7 + ?X],?Y)))'
		description:
			'Does one work when it contains a Smalltalk term containing a logic variable'