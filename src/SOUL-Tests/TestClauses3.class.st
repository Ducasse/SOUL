Class {
	#name : #TestClauses3,
	#superclass : #TestClauses,
	#category : 'SOUL-Tests'
}

{ #category : #'Dynamic tests' }
TestClauses3 >> dynamicM1 [

dynamic(testDynamicPredicate)
]

{ #category : #'soul auto saved' }
TestClauses3 >> supportsTestValueForXM2 [

?self supportsTestValueFor: ?y if 
	?self testValueFor: ?y = ?someVal
]

{ #category : #'soul auto saved' }
TestClauses3 >> testValueForXEM3 [

?self testValueFor: 1 = 1.
?self testValueFor: 1 = 11.
?self testValueFor: 2 = 2.
?self testValueFor: 1 = 111
]

{ #category : #'soul auto saved' }
TestClauses3 >> testsForXM2 [

2 testsFor: 3.
1 testsFor: 2
]

{ #category : #'soul auto saved' }
TestClauses3 >> trueRuleM1 [

?o trueRule.
?o trueRule
]
