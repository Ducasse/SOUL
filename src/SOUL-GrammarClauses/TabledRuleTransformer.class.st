Class {
	#name : #TabledRuleTransformer,
	#superclass : #Object,
	#instVars : [
		'tabledCall',
		'tabledRule'
	],
	#category : 'SOUL-GrammarClauses'
}

{ #category : #'As yet unclassified' }
TabledRuleTransformer class >> with: aCondition fromRule: aTabledRule [
	
	^self new with: aCondition fromRule: aTabledRule
]

{ #category : #'initialize-release' }
TabledRuleTransformer >> tabledCall [
	
	^tabledCall
]

{ #category : #converting }
TabledRuleTransformer >> transform: vars [
	
	^self transform: vars withInteger: 0
]

{ #category : #converting }
TabledRuleTransformer >> transform: vars withInteger: anInteger [
	
	^self subclassResponsibility
]

{ #category : #'initialize-release' }
TabledRuleTransformer >> with: aTerm fromRule: aTabledRule [
	
	tabledCall := aTerm.
	tabledRule := aTabledRule
]
