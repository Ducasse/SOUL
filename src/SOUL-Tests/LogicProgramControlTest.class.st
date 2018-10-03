Class {
	#name : #LogicProgramControlTest,
	#superclass : #LogicTests,
	#classVars : [
		'DoTestMemory'
	],
	#category : 'SOUL-Tests'
}

{ #category : #doTestMemory }
LogicProgramControlTest class >> doTestMemory [
	"This shared variable serves as memory to test side-effects in the do/1 predicate"

	
	^DoTestMemory
]

{ #category : #doTestMemory }
LogicProgramControlTest class >> incrementDoTestMemory [
	"This shared variable serves as memory to test side-effects in the do/1 predicate"

	
	DoTestMemory := self doTestMemory + 1
]

{ #category : #'initialize-release' }
LogicProgramControlTest class >> initialize [
	"Reset the default repository because a logic test repository needs to be included."

	
	SoulFactory resetDefaultRepository
]

{ #category : #doTestMemory }
LogicProgramControlTest class >> resetDoTestMemory [
	"This shared variable serves as memory to test side-effects in the do/1 predicate"

	
	DoTestMemory := 0
]

{ #category : #'meta programming' }
LogicProgramControlTest >> testapply2 [
	"self run:#testapply2"

	
	self processQuery: ' if succeeds(apply(fact2,<onlyOccurence>))'
		description:
			'This should work because it is equivalent to calling fact2(onlyOccurence) which is supposed to work'.
	self processQuery: ' if succeeds(apply(fact2,<?x>))' description:
			'This should work because it is equivalent to calling fact2(?x) which is supposed to work'.
	self processQuery:
			' if succeeds(and(apply(fact2,<?x>),equals(?x,onlyOccurence)))'
		description:
			'This should work because it is equivalent to calling fact2(?x) which indeed returns onlyOccurence as a possible value for ?x'
]

{ #category : #'meta programming' }
LogicProgramControlTest >> testcase [
	"self run:#testcase"

	
	self processQuery:
			' if equals(?X,0),case(cond(smaller(?X,1),equals(?Result,firstCase)),cond(smaller(?X,4),equals(?Result,secondCase)),cond([true],equals(?Result,thirdCase))),equals(?Result,firstCase)'
		description: 'Does case succeed for the first case?'.
	self processQuery:
			' if equals(?X,2),case(cond(smaller(?X,1),equals(?Result,firstCase)),cond(smaller(?X,4),equals(?Result,secondCase)),cond([true],equals(?Result,thirdCase))),equals(?Result,secondCase)'
		description: 'Does case succeed for the second case?'.
	self processQuery:
			' if equals(?X,5),case(cond(smaller(?X,1),equals(?Result,firstCase)),cond(smaller(?X,4),equals(?Result,secondCase)),cond([true],equals(?Result,thirdCase))),equals(?Result,thirdCase)'
		description: 'Does case succeed for the last case?'.
	self
		processQuery:
			' if equals(?X,0),[LogicProgramControlTest resetDoTestMemory.
true],case(cond(smaller(?X,1),[LogicProgramControlTest incrementDoTestMemory.
true]),cond(smaller(?X,4),[LogicProgramControlTest incrementDoTestMemory.
true]),cond([true],[LogicProgramControlTest incrementDoTestMemory.
true]))'
		resultsCheck: [:result | self class doTestMemory = 1]
		description: 'Check that the case indeed executes only the first action'
]

{ #category : #'sets of solutions' }
LogicProgramControlTest >> testconstrain [
	"self run:#testconstrain"

	"constrain/2"

	"Can the author of constrain/2 (Roel?) please add some adequate tests for the predicate constrain/2 here?"

	
	self
		processQuery: ' if constrain(?c,[Smalltalk allClasses])'
		resultsCheck: [:results | results size = Smalltalk allClasses size]
		description: 'constrain/2'.
	self processQuery: ' if constrain([Object],[Smalltalk allClasses])'
		description: 'constrain/2'
]

{ #category : #'meta programming' }
LogicProgramControlTest >> testdo1 [
	"self run:#testdo1"

	"do/1"

	
	self processQuery: ' if do(writeLn([''Hallo'']))' description:
			'Does do/1 succeed when the action succeeds?'.
	self processQuery: ' if do(and(writeLn([''Hallo'']),[false]))'
		description: 'Does do/1 succeed even when the action fails?'.
	self
		processQuery:
			' if [LogicProgramControlTest resetDoTestMemory.
true],do([LogicProgramControlTest incrementDoTestMemory.
true])'
		resultsCheck: [:result | self class doTestMemory = 1]
		description: 'Does do/1 produce the expected side-effect?'.
	self
		processQuery:
			' if [LogicProgramControlTest resetDoTestMemory.
true],do(and([LogicProgramControlTest incrementDoTestMemory.
true],[false]))'
		resultsCheck: [:result | self class doTestMemory = 1]
		description:
			'Does do/1 produce the expected side-effect even when the action fails?'
]

{ #category : #'sets of solutions' }
LogicProgramControlTest >> testexactlyOne [
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
]

{ #category : #'meta programming' }
LogicProgramControlTest >> testexists [
	"self run:#testexists"

	
	self processQuery: ' if exists(fact2(?x))' description:
			'Does exists/1 work if there is exactly one solution for the query?'.
	self processQuery: ' if exists(fact1(?x))' description:
			'Does exists/1 work if there are multiple solutions for the query?'.
	self processQuery: ' if not(exists(fact1(z)))' description:
			'Does exists/1 fail if there are no solutions for the query?'.
	self processQuery: ' if exists(fact1(a),fact1(a))' description:
			'Does exists/2 work if there is solution for the expression and the query?'.
	self processQuery: ' if exists(fact1(?x),member(?x,<a>))' description:
			'Does exists/2 work if there is solution for the expression and the query?'.
	self processQuery: ' if not(exists(fact1(?x),member(?x,<z>)))'
		description:
			'Does exists/2 fail if there is solution for the expression and not for the query?'.
	self processQuery: ' if not(exists(fact1(z),member(a,<a>)))' description:
			'Does exists/2 fail if there is no solution for the expression but there is one for the query?'.
	self processQuery: ' if not(exists(fact1(z),member(z,<a>)))' description:
			'Does exists/2 fail if there is no solution for the expression and for the query?'
]

{ #category : #'meta programming' }
LogicProgramControlTest >> testexists1 [
	"self run:#testexists1"

	"exists/1"

	
	self processQuery: ' if succeeds(exists(list(<>)))' description:
			'Does there exist an empty list?'.
	self processQuery: ' if fails(exists(list([1])))' description:
			'Does no solution exist to the query list([1])?'.
	self processQuery: ' if exists(member(1,<1,2,3>))' description:
			'Does there exists a member 1 in the list <1,2,3>?'.
	self processQuery: ' if exists(member(1,<2,1,3,1>))' description:
			'Does there exist a member 1 in a list containing multiple occurences of 1? (Note that this query is supposed to return one result only, because exists/1 is implemented lazily.)'.
	self processQuery: ' if exists(and(equals(?X,7),equals([7 + ?X],?Y)))'
		description:
			'Does exists/1 work when it contains a Smalltalk term containing a logic variable'
]

{ #category : #'meta programming' }
LogicProgramControlTest >> testexists2 [
	"self run:#testexists2"

	"exists/2"

	
	self processQuery:
			' if succeeds(exists(equals(?X,7),equals([7 + ?X],?Y)))' description:
			'Does exists/1 work when it contains a Smalltalk term containing a logic variable'.
	self processQuery:
			' if succeeds(exists(member(?X,<1,2,3,4>),greater(?X,3)))' description:
			'Does there exist a member ?X of a list <1,2,3,4> that is strictly greater than 3?'
]

{ #category : #'meta programming' }
LogicProgramControlTest >> testfails [
	"self run:#testfails"

	"fails/1"

	
	self processQuery: ' if succeeds(fails(list([1])))' description:
			'Does fails succeed in case of a negative result?'.
	self processQuery: ' if fails(fails(list(<>)))' description:
			'Does fails fail in case of a positive result?'
]

{ #category : #'sets of solutions' }
LogicProgramControlTest >> testfindall [
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
]

{ #category : #'sets of solutions' }
LogicProgramControlTest >> testforall1 [
	"self run: #testforall1"

	"forall/1"

	
	self processQuery:
			' if succeeds(forall(and(member(?x,<[1],[2],[3]>),integer(?x))))'
		description:
			'For every member of a list of integers, is it indeed an integer?'.
	self processQuery: ' if fails(forall(member(?x,<>)))' description:
			'When the query to be tested is false, forall/1 should succeed. Indeed, in that case: for all solutions that satisfy this query (that is none) the true condition will succeed.'
]

{ #category : #'sets of solutions' }
LogicProgramControlTest >> testforall2 [
	"self run: #testforall2"

	"self debug: #testforall2"

	"forall/2"

	
	self processQuery: ' if succeeds(forall(member(?x,<[1],[2],[3]>),[true]))'
		description:
			'For every member of a list of integers, does the trivial test succeed?'.
	self processQuery: ' if fails(forall(member(?x,<[1],[2],[3]>),[false]))'
		description:
			'When the condition to be tested is false, the query should clearly fail'.
	self processQuery: ' if succeeds(forall(member(?x,<>),[false]))'
		description: 'Unless when forall works on an empty set'.
	self processQuery:
			' if succeeds(forall(member(?x,<[1],[2],[3]>),integer(?x)))'
		description:
			'For every member of a list of integers, is it indeed an integer?'.
	self processQuery:
			' if succeeds(forall(member(?c,<a,a,a>),and(nonvar(?c),equals(?c,a))))'
		description:
			'Is every member of a list of symbols a equal to the symbol a?'.
	self processQuery:
			' if fails(forall(member(?c,<a,b,c>),and(nonvar(?c),equals(?c,a))))'
		description:
			'Is every member of a list of different symbols equal to the symbol a?'.
	self processQuery: ' if succeeds(forall(member(?x,<>),writeLn(?x)))'
		description:
			'Does forall/2 work when the first argument produces no results?'.
	self processQuery:
			' if succeeds(forall(member(?x,<[1],[2],[3]>),writeLn(?x)))'
		description: 'Can forall/2 be used for its side-effects?'.
	self processQuery:
			' if equals(?coll,[OrderedCollection new]),forall(member(?x,<[1],[2]>),[?x < 3])'
		description:
			'Can forall/2 have smalltalkblocks in the testquery with variables from the first query?'.
	self processQuery:
			' if succeeds(and(forall(member(?x,<[1],[2],[3]>),writeLn(?x)),var(?x)))'
		description:
			'After calling a forall/2, are all the explicit internal variables made unbound again?'.
	self processQuery:
			' if succeeds(and(forall(member(?x,<1,2,3>),equals(?x,?y)),var(?x),var(?y)))'
		description:
			'After calling a forall/2, are all the explicit and implicit internal variables made unbound again?'.
	self processQuery:
			' if succeeds(and(forall(fact1(?AString),writeLn(?AString)),var(?AString)))'
		description:
			'Does this print on the transcript a, a, a, b, b, c each separated by a newline and is the variable ?AString unbound after calling forall/2?'.
	self processQuery:
			' if succeeds(and(forall(fact1(?AString),writeLn(?AString)),var(?AString)))'
		description:
			'Does this print on the transcript a, a, a, b, b, c each separated by a newline and is the variable ?AString unbound after calling forall/2?'.
	self processQuery:
			' if succeeds(and(forall(fact1(?AString),and(write(?AString),writeLstLn(<foo,bar>))),var(?AString)))'
		description:
			'Does this print on the transcript afoobar, afoobar, afoobar, bfoobar, bfoobar, cfoobar each separated by a newline and is the variable ?AString unbound after calling forall/2?'.
	self processQuery:
			' if succeeds(and(forall(fact1(?AString),and(findall(?S,and(fact1(?S),equals(?S,?AString)),?ASet),writeLn(?AString))),var(?AString),var(?ASet)))'
		description:
			'Does this print on the transcript a, a, a, b, b, c each separated by a newline and are the variables ?AString and ?ASet unbound after calling forall/2?'.
	self processQuery:
			' if succeeds(and(forall(fact1(?AString),and(findall(?S,and(fact1(?S),equals(?S,?AString)),?ASet),write(?AString),writeLstLn(<foo,bar>))),var(?AString),var(?ASet)))'
		description:
			'Does this print on the transcript afoobar, afoobar, afoobar, bfoobar, bfoobar, cfoobar each separated by a newline and are the variables ?AString and ?ASet unbound after calling forall/2?'.
	self processQuery: ' if succeeds(forall(equals(?x,1),[?x > 0]))'
		description:
			'Does forall work when the test is a smalltalk term containing variables generated by the query?'.
	self processQuery: ' if succeeds(forall(equals(?x,?y),not(ground(?x))))'
		description:
			'Does forall work when the query generates solutions containing unbound variables that are used in the test?'.
	self processQuery:
			' if counterincr(?c),not(forall(member(?x,<a,a,a,b,a,c,c,c>),and(counterincr(?c),equals(?x,a)))),countervalue(?c,5)'
		description:
			'Is the evaluation of forall shortcut so that as soon as the test fails for one of the query''s solutions, the other solutions are not tested?'
]

{ #category : #'sets of solutions' }
LogicProgramControlTest >> testforall3 [
	"self run:#testforall3"

	"forall/3"

	
	self processQuery:
			' if succeeds(and(forall(member(?e,<[1],[2],[3]>),equals(?e,[2]),?L),length(?L,2)))'
		description:
			'forall/3 is not lazy and produces a list containing as many elements as there are failures'.
	self processQuery:
			' if succeeds(and(forall(member(?e,<[1],[2],[3]>),equals(?e,[2]),?L),equals(?L,<equals([1],[2]),equals([3],[2])>)))'
		description: 'forall/3 correctly produces all failures'.
	self processQuery:
			' if succeeds(forall(member(?e,<[1],[2],[3]>),integer(?e),<>))'
		description: 'forall/3 produces an empty list when all test succeed'
]

{ #category : #'sets of solutions' }
LogicProgramControlTest >> testforeach [
	"self run: #testforeach"

	"foreach/2"

	
	self processQuery: ' if succeeds(foreach(<1,2,3>,write))' description:
			'Does this print 123 on the Transcript?'
]

{ #category : #'meta programming' }
LogicProgramControlTest >> testifThenElse [
	"self run:#testifThenElse"

	"ifThenElse/3"

	
	self processQuery:
			' if succeeds(and(equals(?X,0),ifThenElse(smaller(?X,1),equals(?Result,trueCase),equals(?Result,falseCase)),equals(?Result,trueCase)))'
		description: 'Does ifThenElse/3 succeed for the true case?'.
	self processQuery:
			' if succeeds(and(equals(?X,2),ifThenElse(smaller(?X,1),equals(?Result,trueCase),equals(?Result,falseCase)),equals(?Result,falseCase)))'
		description: 'Does ifThenElse/3 succeed for the false case?'
]

{ #category : #'sets of solutions' }
LogicProgramControlTest >> testnodup [
	"self run:#testnodup"

	"nodup/1"

	
	self
		processQuery: ' if nodup(member(?x,<1,2,3,1>))'
		resultsCheck: [:results | results size = 3]
		description:
			'Does nodup/1 behave as expected when query contains free variables?'.
	self processQuery: ' if fails(nodup(member(4,<1,2,3,1>)))' description:
			'Does nodup/1 fail when the tested query fails?'
]

{ #category : #'meta programming' }
LogicProgramControlTest >> testone [
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
]

{ #category : #'meta programming' }
LogicProgramControlTest >> testsucceeds [
	"self run:#testsucceeds"

	"succeeds/1"

	
	self processQuery: ' if fails(succeeds(list([1])))' description:
			'Does succeeds fail in case of a negative result?'.
	self processQuery: ' if succeeds(succeeds(list(<>)))' description:
			'Does succeeds succeed in case of a positive result?'.
	self processQuery: ' if succeeds(and(equals(?X,7),equals([7 + ?X],?Y)))'
		description:
			'Does succeeds work when it contains a Smalltalk term containing a logic variable'
]

{ #category : #'meta programming' }
LogicProgramControlTest >> testxor [
	"self run:#testxor"

	"xor/2"

	
	self processQuery: ' if succeeds(xor(integer([1]),var([1])))' description:
			'Does xor/2 succeed when first argument succeeds and second fails?'.
	self processQuery: ' if succeeds(xor(integer(?x),var(?x)))' description:
			'Does xor/2 succeed when first argument fails and second succeeds?'.
	self processQuery: ' if fails(xor(integer([1]),positiveInteger([1])))'
		description: 'Does xor/2 fail when both arguments are true?'.
	self processQuery: ' if fails(xor(zero([1]),positiveInteger([-1])))'
		description: 'Does xor/2 fail when both arguments fail?'.
	self processQuery:
			' if fails(xor(equals(?x,[#first]),equals(?y,[#second])))' description:
			'Does xor/2 when both arguments succeed?'.
	self processQuery:
			' if succeeds(and(equals(?x,[#dummy]),xor(equals(?x,[#first]),equals(?y,[#second])),nonvar(?x),equals(?x,[#dummy]),nonvar(?y),equals(?y,[#second])))'
		description:
			'Can xor/2 be used to select the second of two instructions?'
]
