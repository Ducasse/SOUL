Class {
	#name : #TabledRuleSLGNotTransformer,
	#superclass : #TabledRuleTransformer,
	#category : 'SOUL-GrammarClauses'
}

{ #category : #converting }
TabledRuleSLGNotTransformer >> transform: vars withInteger: anInteger [
	
	^'slgnot' , '(?Id, ' , vars asString , ','
		, tabledCall termSequence asString ,
			',[ Array with: (OrderedCollection new) with: (OrderedCollection new) ],'
		, 'cont' , anInteger asString , tabledRule predicate asString , ')'
]
