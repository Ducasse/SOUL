Class {
	#name : #SymbiosisFactory,
	#superclass : #StandardSoulFactory,
	#category : 'SOUL-SmalltalkSymbiosis'
}

{ #category : #installing }
SymbiosisFactory class >> installSymbiosisFactory [
	
	self initialize: self new
]

{ #category : #installing }
SymbiosisFactory class >> revertTo: aFactory [
	
	self initialize: aFactory.
	LogicStorage reReadAllStorage
]

{ #category : #evaluators }
SymbiosisFactory >> evaluatorForLogicQuery [
	
	^EvaluatorForSymbiosis
]

{ #category : #terms }
SymbiosisFactory >> makeMessageTerm [
	
	^SymbioticMessageTerm
]

{ #category : #terms }
SymbiosisFactory >> makeResultMessageTerm [
	
	^SymbioticResultMessageTerm
]

{ #category : #kernel }
SymbiosisFactory >> makeResults [
	
	^SymbioticSOULResults
]
