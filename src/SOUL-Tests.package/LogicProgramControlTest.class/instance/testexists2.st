meta programming
testexists2
	"self run:#testexists2"

	"exists/2"

	
	self processQuery:
			' if succeeds(exists(equals(?X,7),equals([7 + ?X],?Y)))' description:
			'Does exists/1 work when it contains a Smalltalk term containing a logic variable'.
	self processQuery:
			' if succeeds(exists(member(?X,<1,2,3,4>),greater(?X,3)))' description:
			'Does there exist a member ?X of a list <1,2,3,4> that is strictly greater than 3?'