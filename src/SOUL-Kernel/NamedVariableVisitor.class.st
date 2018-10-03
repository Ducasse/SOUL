"
I walk a Soul parse tree and apply an action on every named variable of that tree. Underscore variables are thus skipped.

Instance Variables:
	doBlock	 <BlockClosure>	the action to be performed on named variables that are encountered


"
Class {
	#name : #NamedVariableVisitor,
	#superclass : #SimpleTermVisitor,
	#instVars : [
		'doBlock'
	],
	#category : 'SOUL-Kernel'
}

{ #category : #'instance creation' }
NamedVariableVisitor class >> doBlock: aBlock [
	
	^self new doBlock: aBlock
]

{ #category : #'visiting terms' }
NamedVariableVisitor >> delayedVariableVisit: aVariable [
	
	doBlock value: aVariable
]

{ #category : #private }
NamedVariableVisitor >> doBlock: aBlock [
	
	doBlock := aBlock
]

{ #category : #'visiting terms' }
NamedVariableVisitor >> nativeClauseVisit: aNativeClause [
	
	| variables |
	variables := aNativeClause variables.
	aNativeClause header do: [:el | el accept: self].
	variables do: [:var | doBlock value: var]
]

{ #category : #'visiting terms' }
NamedVariableVisitor >> smalltalkTermVisit: anSTTerm [
	
	| variables |
	variables := anSTTerm variables.
	(1 to: variables size) do: [:index | doBlock value: (variables at: index)]
]

{ #category : #'visiting terms' }
NamedVariableVisitor >> templateQueryTermVisit: aTemplateQueryTerm [
	
	aTemplateQueryTerm content do: [:subterm | subterm accept: self].
	aTemplateQueryTerm variables do: [:subterm | subterm accept: self].
	aTemplateQueryTerm parsetrees do: [:tree | tree accept: self].
	aTemplateQueryTerm queries do: [:query | (query at: 1) accept: self].
	aTemplateQueryTerm type accept: self
]

{ #category : #'visiting terms' }
NamedVariableVisitor >> underscoreVariableVisit: aVariable [
	
	^self
]

{ #category : #'visiting terms' }
NamedVariableVisitor >> variableVisit: aVariable [
	
	doBlock value: aVariable
]
