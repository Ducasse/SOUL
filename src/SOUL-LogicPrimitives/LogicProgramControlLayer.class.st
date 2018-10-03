Class {
	#name : #LogicProgramControlLayer,
	#superclass : #LogicPrimitives,
	#category : 'SOUL-LogicPrimitives'
}

{ #category : #'SLG resolution' }
LogicProgramControlLayer >> answerM3 [

answer(?id,?call,?delayed) if 
	[SoulFactory answer: ?call forCID: ?id using: ?delayed.
false]
]

{ #category : #evals }
LogicProgramControlLayer >> applyM2 [

"apply(?PredicateName,?ArgumentList) applies the predicate with name ?PredicateName to a
	 given ?ArgumentList. For example, apply(foo,<bar,zork>) is equivalent to calling foo(bar,zork)."

apply(?PredicateName,?ArgumentList) if 
	equalsStructureList(?Query,<?PredicateName|?ArgumentList>),?Query
]

{ #category : #'soul auto saved' }
LogicProgramControlLayer >> caseQ [

"case is a predicate that can take an arbitrary list of parameters of the form
	 cond(?Condition,?Action). It works as follows: the ?Action corresponding to the
	 first succesful ?Condition is executed. The remaining conditions and actions
	 are then ignored (in other words, only one case can be fired)."

case@(<cond(?Condition,&Action)|?Cases>) if 
	one(or(and(?Condition,do(&Action)),apply(case,?Cases)))
]

{ #category : #'soul auto saved' }
LogicProgramControlLayer >> constrainM2 [

"tested

constrain/2 does a generate and check operation, in other words a kind of domain check. For example:
		constrain(?c, [Smalltalk allClasses])
	If ?c has a value, then it is ensured that this is a Smalltalk class.   
	if ?c is a variable, values for ?c are generated"

constrain(?term,?smalltalkTerm) if 
	nonvar(?smalltalkTerm),collectionMember(?generatedTerm,?smalltalkTerm),equals(?term,?generatedTerm)
]

{ #category : #evals }
LogicProgramControlLayer >> countM2 [

"count(+?Query,?NumberOfResults) counts how many results there are for ?Query. Note that
the query is supposed to be instantiated upon calling this predicate."

count(+?Query,?NumberOfResults) if 
	findall(dummy,?Query,?list),length(?list,?NumberOfResults)
]

{ #category : #'bad imperative  predicates' }
LogicProgramControlLayer >> doM1 [

"do(?Action) does a certain ?Action for its side-effects. Whether are not the action succeeds
	 or fails we don't care, the do-predicate will execute the side-effects and will always succeed."

do(?Action) if 
	succeeds(or(?Action,[true]))
]

{ #category : #evals }
LogicProgramControlLayer >> exactlyOneM1 [

"tested on 09-07-2001

exactlyOne(+?Query) tests whether some ?Query produces exactly one result. Note that
	 the query is supposed to be instantiated upon calling this predicate."

exactlyOne(+?Query) if 
	findall(dummy,?Query,<?>),?Query
]

{ #category : #evals }
LogicProgramControlLayer >> existsM1 [

"reimplemented

not tested

exists(+?Query) checks whether there exists at least one solution for ?Query.
	?Query is supposed to be instantiated with a valid logic expression."

exists(?Query) if 
	one(?Query)
]

{ #category : #evals }
LogicProgramControlLayer >> existsM2 [

"reimplemented

not tested

exists(+?Expression,+?Query) checks whether there exists a solution for ?Expression,
	for which the query ?Query is satisfied. Both ?Expression and ?Query must be
	instantiated with valid logic expressions."

exists(?Expression,?Query) if 
	exists(and(?Expression,?Query))
]

{ #category : #evals }
LogicProgramControlLayer >> failsM1 [

"tested

fails(+?Query) succeeds if ?Query fails and succeeds if ?Query fails.
?Query is supposed to be instantiated with a valid logic query."

fails(&Query) if 
	not(&Query)
]

{ #category : #iterators }
LogicProgramControlLayer >> filterDupsM2 [

filterDups(<>,<>).
filterDups(<?car|?cdr>,?rest) if 
	member(?car,?cdr),filterDups(?cdr,?rest).
filterDups(<?car|?cdr>,<?car|?rest>) if 
	not(member(?car,?cdr)),filterDups(?cdr,?rest)
]

{ #category : #iterators }
LogicProgramControlLayer >> findallM3 [

"tested on 09-07-2001"

findall(&term,&query,?list) if 
	getEnv(?env,?envIdx),envLookup(&query,?queryPointer),envLookup(&term,?termPointer),deify(?list,[| ruleSelector holdcallStack oldFrame results hisIndex copier |
ruleSelector := SoulFactory current makeRuleSelector new.
holdcallStack := ?env callStack.
oldFrame := ?env currentFrame.
ruleSelector evalTermApplication: ?queryPointer inEnv: ?env.
results := OrderedCollection new.
[ruleSelector next == false]
	whileFalse:
		[results
			add:
				(?termPointer term soulUp
					soulDownIn: ?env
					startAt: ?termPointer envIndex) soulUp].
?env callStack: holdcallStack.
?env currentFrame: oldFrame.
copier := CopyingVisitor new.
(SoulFactory current makeList termSequence: (TermSequence terms: results))
	accept: copier])
]

{ #category : #iterators }
LogicProgramControlLayer >> forallM1 [

"forall(?query) checks whether all possible evaluation paths for ?query succeed.
	 If the ?query itself fails, then forall/1 also fails as there are no evaluation paths for
	?query that have succeeded."

forall(?query) if 
	exists(?query),forall(?query,[true])
]

{ #category : #iterators }
LogicProgramControlLayer >> forallM2 [

forall(?query,&test) if 
	not(?query,not(&test))
]

{ #category : #iterators }
LogicProgramControlLayer >> forallM3 [

"tested 03/04/2002

implemented by KM - 03/04/2002

forall(?query, ?test, ?failures) is related to forall/2, but also returns the elements from ?query 
	that failed the ?test. These are returned in the ?failures list. In fact, it is more like a findall/3 in
	the sense that it accumulates a list of all solutions of ?query that fail the ?test.
	Note: The regular forall stops with the first element it encounters that does 
		not satisfy ?test. This forall/3 does not: it will check for all results 
		of query too whether they satisfy ?test or not.

For example:	forall(	member(?e,<[1], [2], [3]>),	equals(?e, [2]),	?L)
	 yields:	?L -> < equals([1],[2]), equals([3],[2])>
	 because [1] and [3] failed the ?test but satisfied the ?query"

forall(?query,?test,?failures) if 
	findall(?test,and(?query,not(?test)),?failures)
]

{ #category : #iterators }
LogicProgramControlLayer >> foreachM2 [

"tested on 29/08/2001

foreach/2

foreach(+?List, +?Predicate) applies the ?Predicate one by one to each of the
	 elements of a list ?List. Both the ?Predicate and the ?List are supposed to be
	 instantiated upon calling foreach/2.

Usage note: This predicate is typically used to apply a predicate with a side
	 effect to each of the elements of a given list. See for example writeLst/1 or
	 writeLnLst/1."

foreach(?List,?Predicate) if 
	list(?List),forall(member(?Item,?List),?Predicate(?Item))
]

{ #category : #'bad imperative  predicates' }
LogicProgramControlLayer >> ifThenElseM3 [

"ifThenElse(?Condition,?True,?False) executes the ?True action when the
	 ?Condition is satisfied and executes the ?False action if not."

ifThenElse(?Condition,?True,?False) if 
	case(cond(?Condition,?True),cond([true],?False))
]

{ #category : #evals }
LogicProgramControlLayer >> nodupM1 [

"tested on 02/04/2002

nodup(?query) computes ?query without duplicate results.
	 Note that this is not a very efficient predicate."

nodup(?query) if 
	findall(?query,?query,?Results),filterDups(?Results,?ResWithoutDuplicates),member(?query,?ResWithoutDuplicates)
]

{ #category : #evals }
LogicProgramControlLayer >> oneM1 [

"tested on 25-10-2001

one(+?Query) returns (only) the first succesful solution for ?Query

?Query must be a valid logic expression (which may include conjunctions
	 and disjunctions)."

one(&query) if 
	&query,!
]

{ #category : #'SLG resolution' }
LogicProgramControlLayer >> slgM1 [

slg(?call) if 
	[SoulFactory slg: ?call] contains: ?call
]

{ #category : #'SLG resolution' }
LogicProgramControlLayer >> slgcallM5 [

slgcall(?id,?vars,?call,?delay,?cont) if 
	[SoulFactory slgcall: ?call forCID: ?id variables: ?vars delay: ?delay
	continuation: ?cont.
false]
]

{ #category : #'SLG resolution' }
LogicProgramControlLayer >> slgnotM5 [

slgnot(?id,?vars,?call,?delay,?cont) if 
	[SoulFactory slgnot: ?call forCID: ?id variables: ?vars delay: ?delay
	continuation: ?cont.
false]
]

{ #category : #evals }
LogicProgramControlLayer >> succeedsM1 [

"tested; to be made more efficient once one/1 has been debugged

succeeds(+?Query) succeeds if ?Query succeeds and fails otherwise.
?Query is supposed to be instantiated with a valid logic query."

succeeds(&Query) if 
	one(&Query)
]

{ #category : #evals }
LogicProgramControlLayer >> xorM2 [

"tested on 09-07-2001

xor(+?Query1,+?Query2) takes two queries as inputs and succeeds if and only if
	 one of both queries succeeds and the other one fails. Both queries are supposed
	 to be filled in before calling this predicate. xor/2 gives an error when called with
	 one of the arguments variable."

xor(&Query1,&Query2) if 
	or(and(&Query1,not(&Query2)),and(&Query2,not(&Query1)))
]
