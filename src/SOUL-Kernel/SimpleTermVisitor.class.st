Class {
	#name : #SimpleTermVisitor,
	#superclass : #Object,
	#category : 'SOUL-Kernel'
}

{ #category : #'visiting terms' }
SimpleTermVisitor >> callTermVisit: aCallTerm [
	
	aCallTerm variable accept: self.
	aCallTerm normalterm accept: self
]

{ #category : #'visiting terms' }
SimpleTermVisitor >> compoundVisit: aCompound [
	
	aCompound functor accept: self.
	aCompound termSequence accept: self.
	aCompound astLink == nil ifFalse: [aCompound astLink accept: self]
]

{ #category : #'visiting terms' }
SimpleTermVisitor >> constantVisit: aConstant [
	
	^aConstant
]

{ #category : #'visiting terms' }
SimpleTermVisitor >> cutVisit: aCut [
	
	^aCut
]

{ #category : #'visiting terms' }
SimpleTermVisitor >> delayedVariableVisit: aVariable [
	
	
]

{ #category : #'visiting terms' }
SimpleTermVisitor >> emptyListConstantVisit: term [
	
	^self constantVisit: term
]

{ #category : #'visiting clauses' }
SimpleTermVisitor >> factVisit: aClause [
	
	aClause condition accept: self.
	aClause conclusion accept: self
]

{ #category : #'visiting terms' }
SimpleTermVisitor >> hiddenVariableVisit: aHiddenVariable [
	
	^self variableVisit: aHiddenVariable
]

{ #category : #'visiting terms' }
SimpleTermVisitor >> keywordFunctorVisit: term [
	"For convenience this method will by default forward the message request to multiPartFunctorVisit: as the visitor's behavior for keyword en message functors will in most cases be the same"

	
	^self multiPartFunctorVisit: term
]

{ #category : #'visiting terms' }
SimpleTermVisitor >> listTermVisit: term [
	
	^self compoundVisit: term
]

{ #category : #'visiting terms' }
SimpleTermVisitor >> messageFunctorVisit: term [
	"For convenience this method will by default forward the message request to multiPartFunctorVisit: as the visitor's behavior for keyword en message functors will in most cases be the same"

	
	^self multiPartFunctorVisit: term
]

{ #category : #'visiting terms' }
SimpleTermVisitor >> multiPartFunctorVisit: aFunctor [
	"See comment in keywordFunctorVisit: and messageFunctorVisit:"

	
	^aFunctor keywords do: [:keyword | keyword accept: self]
]

{ #category : #'visiting clauses' }
SimpleTermVisitor >> nativeClauseVisit: aClause [
	
	
]

{ #category : #'visiting terms' }
SimpleTermVisitor >> objectVisit: anObject [
	
	^self
]

{ #category : #'visiting clauses' }
SimpleTermVisitor >> queryVisit: aClause [
	
	aClause condition accept: self
]

{ #category : #'visiting terms' }
SimpleTermVisitor >> quotedCodeTermVisit: aQuotedCodeBlock [
	
	aQuotedCodeBlock variables do: [:subterm | subterm accept: self]
]

{ #category : #'visiting terms' }
SimpleTermVisitor >> resultMessageTermVisit: rmTerm [
	
	rmTerm message accept: self.
	rmTerm result accept: self
]

{ #category : #'visiting clauses' }
SimpleTermVisitor >> ruleVisit: aClause [
	
	aClause condition accept: self.
	aClause conclusion accept: self
]

{ #category : #'visiting terms' }
SimpleTermVisitor >> smalltalkTermVisit: anSTTerm [
	"UGLY: should we also recursively visit the variables used in the smalltalk term by default?"
	
	
]

{ #category : #'visiting terms' }
SimpleTermVisitor >> templateQueryTermVisit: aTemplateQueryTerm [
	
	aTemplateQueryTerm content do: [:subterm | subterm accept: self].
	aTemplateQueryTerm variables do: [:subterm | subterm accept: self].
	aTemplateQueryTerm parsetrees do: [:tree | tree accept: self].
	aTemplateQueryTerm queries do: [:query | (query at: 1) accept: self].
	aTemplateQueryTerm type accept: self
]

{ #category : #'visiting terms' }
SimpleTermVisitor >> termSequenceVisit: aTermSequence [
	
	aTermSequence terms do: [:subTerm | subTerm accept: self]
]

{ #category : #'visiting terms' }
SimpleTermVisitor >> unaryMessageFunctorVisit: unaryMessageFunctor [
	
	^unaryMessageFunctor message accept: self
]

{ #category : #'visiting terms' }
SimpleTermVisitor >> underscoreVariableVisit: aVariable [
	
	
]

{ #category : #'visiting terms' }
SimpleTermVisitor >> variableVisit: aVariable [
	
	
]

{ #category : #'visiting terms' }
SimpleTermVisitor >> visitAnnotatedTerm: anAnnotatedTerm [
	
	anAnnotatedTerm term accept: self.
	anAnnotatedTerm annotation accept: self
]
