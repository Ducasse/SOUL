"
Instances represent unification degrees and behave as booleans.

Although regular Soul only uses crisp degrees, putting its definition here instead of in the fuzzy Soul package saves us from having to specialize MLI's and domain-specific unifications for both variants. 

For instance, domain-specific unifications defined by Cava on the org.eclipse.jdt.dom hierarchy use this class rather than booleans such that one definition suffices for crisp Soul and fuzzy Soul. 
"
Class {
	#name : #Maybe,
	#superclass : #Object,
	#instVars : [
		'degree'
	],
	#category : 'SOUL-Kernel'
}

{ #category : #'instance creation' }
Maybe class >> degree: aNumber [
	
	aNumber = 0 ifTrue: [^false].
	aNumber = 1 ifTrue: [^true].
	^self new degree: aNumber
]

{ #category : #'logical operations' }
Maybe >> & alternativeObject [
	"Evaluating conjunction.  Answer alternativeObject since receiver is true."

	
	^alternativeObject
]

{ #category : #controlling }
Maybe >> and: alternativeBlock [
	"Nonevaluating conjunction -- answer the value of alternativeBlock since
	the receiver is true."

	"Execution does not actually reach here because the expression is compiled in-line."

	
	^alternativeBlock value
]

{ #category : #accessing }
Maybe >> degree [
	
	^degree
]

{ #category : #accessing }
Maybe >> degree: anObject [
	
	degree := anObject
]

{ #category : #delegation }
Maybe >> doesNotUnderstand: aMessage [
	
	^self degree > 0
		perform: aMessage selector
		withArguments: aMessage arguments
]

{ #category : #controlling }
Maybe >> ifFalse: alternativeBlock [
	"Since the condition is true, the value is the true alternative, which 
	is nil. This method is typically not invoked because ifTrue:/ifFalse: 
	expressions are compiled in-line for literal blocks."

	
	^nil
]

{ #category : #controlling }
Maybe >> ifFalse: falseAlternativeBlock ifTrue: trueAlternativeBlock [
	"Answer the value of trueAlternativeBlock. This method is typically 
	not invoked because ifTrue:/ifFalse: expressions are compiled in-line 
	for literal blocks."

	
	^trueAlternativeBlock value
]

{ #category : #controlling }
Maybe >> ifTrue: alternativeBlock [
	"Answer the value of alternativeBlock. This method is typically not 
	invoked because ifTrue:/ifFalse: expressions are compiled in-line for 
	literal blocks."

	
	^alternativeBlock value
]

{ #category : #controlling }
Maybe >> ifTrue: trueAlternativeBlock ifFalse: falseAlternativeBlock [
	"Answer the value of trueAlternativeBlock. This method is typically 
	not invoked because ifTrue:/ifFalse: expressions are compiled in-line 
	for literal blocks."

	
	^trueAlternativeBlock value
]

{ #category : #testing }
Maybe >> isMaybe [
	
	^true
]

{ #category : #testing }
Maybe >> mustBeBoolean [
	
	^true
]

{ #category : #'logical operations' }
Maybe >> not [
	"Negation--answer false since the receiver is true."

	
	^false
]

{ #category : #controlling }
Maybe >> or: alternativeBlock [
	"Nonevaluating disjunction -- answer true since the receiver is true."

	"Execution does not actually reach here because the expression is compiled in-line."

	
	^self
]

{ #category : #'logical operations' }
Maybe >> | aBoolean [
	"Evaluating disjunction (OR) -- answer true since the receiver is true."

	
	^self
]
