Class {
	#name : #TestClauses2,
	#superclass : #TestClauses,
	#category : 'SOUL-Tests'
}

{ #category : #'soul auto saved' }
TestClauses2 >> fact3M1 [

"Do not change these facts!! The result of some unit tests depends on the actual facts defined here.

What we will be testing here is what happened when a set of facts with the same head  is defined in
	 multiple classes: can we see them all, or only those of one of the classes?"

fact3(firstOccurenceInOtherClass).
fact3(secondOccurenceInOtherClass)
]

{ #category : #'soul auto saved' }
TestClauses2 >> testcutonfinalM1 [

testcutonfinal(a).
testcutonfinal(b).
testcutonfinal(c) if 
	!
]
