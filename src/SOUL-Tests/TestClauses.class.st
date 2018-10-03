Class {
	#name : #TestClauses,
	#superclass : #TestQueriesLayer,
	#category : 'SOUL-Tests'
}

{ #category : #'soul auto saved' }
TestClauses >> fooTestM1 [

fooTest(1).
fooTest(2)
]

{ #category : #'soul auto saved' }
TestClauses >> testNegVariableM1 [

testNegVariable(-?x)
]

{ #category : #'soul auto saved' }
TestClauses >> testNegVariableM2 [

testNegVariable(?x,-?y) if 
	equals(?x,?y)
]
