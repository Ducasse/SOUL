Class {
	#name : #TestClauses1,
	#superclass : #TestClauses,
	#category : 'SOUL-Tests'
}

{ #category : #'soul auto saved' }
TestClauses1 >> fact1M1 [

"Do not change these facts!! The result of some unit tests depends on the actual facts defined here"

fact1(a).
fact1(a).
fact1(a).
fact1(b).
fact1(b).
fact1(c)
]

{ #category : #'soul auto saved' }
TestClauses1 >> fact2M1 [

"Do not change these facts!! The result of some unit tests depends on the actual facts defined here"

fact2(onlyOccurence)
]

{ #category : #'soul auto saved' }
TestClauses1 >> fact3M1 [

"Do not change these facts!! The result of some unit tests depends on the actual facts defined here.

What we will be testing here is what happened when a set of facts with the same head  is defined in
	 multiple classes: can we see them all, or only those of one of the classes?"

fact3(firstOccurence).
fact3(secondOccurence)
]

{ #category : #'soul auto saved' }
TestClauses1 >> findalltestM2 [

findalltest(?list,?results) if 
	findall(result(?foo,?bar),and(member(?foo,?list),member(?bar,?list)),?results)
]

{ #category : #'soul auto saved' }
TestClauses1 >> fooXbaarXM3 [

?some foo: ?x baar: ?y
]

{ #category : #'soul auto saved' }
TestClauses1 >> fooXbarXselXM3 [

foo: bla bar: ?tokens1 sel: ?tokens3 if 
	{test},foo: bla bar: ?tokens2 sel: ?tokens3.
foo: bla bar: ?tokens1 sel: ?tokens2 if 
	foo(?tokens1,?tokens2)
]

{ #category : #'soul auto saved' }
TestClauses1 >> fooXbarXtestXM3 [

foo: bla bar: ?tokens1 test: ?tokens3 if 
	{test},foo: bla bar: ?tokens2 test: ?tokens3.
foo: bla bar: ?tokens1 test: ?tokens2 if 
	foo(?tokens1,?tokens2)
]

{ #category : #'soul auto saved' }
TestClauses1 >> metaFactM1 [

metaFact(fact3(firstOccurence))
]
