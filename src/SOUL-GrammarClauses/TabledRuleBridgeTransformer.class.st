Class {
	#name : #TabledRuleBridgeTransformer,
	#superclass : #TabledRuleTransformer,
	#category : 'SOUL-GrammarClauses'
}

{ #category : #converting }
TabledRuleBridgeTransformer >> transform: vars withInteger: anInteger [
	"^'slgcall(?Id', vars asString, ','
			 ,tabledCall printString,  ',[ OrderedCollection with: (OrderedCollection new) with: (OrderedCollection new) ],' 
			, tabledRule predicate asString, 'cont', anInteger asString, ')'."

	
	^self halt: 'bridge predicate detected'
]
