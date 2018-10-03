Class {
	#name : #CopyingVisitor,
	#superclass : #SimpleTermVisitor,
	#category : 'SOUL-Kernel'
}

{ #category : #'visiting terms' }
CopyingVisitor >> callTermVisit: aCallTerm [
	
	^aCallTerm class
		variable: (aCallTerm variable accept: self)
		term: (aCallTerm normalterm accept: self)
]

{ #category : #'visiting terms' }
CopyingVisitor >> compoundVisit: aCompound [
	
	^aCompound class
		functor: (aCompound functor accept: self)
		termSequence: (aCompound termSequence accept: self)
		astLink:
			(aCompound astLink == nil
				ifTrue: [nil]
				ifFalse: [aCompound astLink accept: self])
]

{ #category : #'visiting terms' }
CopyingVisitor >> constantVisit: aConstant [
	
	^aConstant class up: aConstant smalltalkValue
]

{ #category : #'visiting terms' }
CopyingVisitor >> cutVisit: aCut [
	
	^aCut class new
]

{ #category : #'visiting terms' }
CopyingVisitor >> delayedVariableVisit: aVariable [
	
	^aVariable class name: aVariable name
]

{ #category : #'visiting clauses' }
CopyingVisitor >> factVisit: aClause [
	
	| copy |
	copy := SoulFactory current makeFact
		condition: (aClause condition accept: self)
		conclusion: (aClause conclusion accept: self).
	copy comment: aClause comment.
	^copy
]

{ #category : #'visiting terms' }
CopyingVisitor >> keywordFunctorVisit: term [
	"For convenience this method will by default forward the message request to multiPartFunctorVisit: as the visitor's behavior for keyword en message functors will in most cases be the same"

	
	^self multiPartFunctorVisit: term
]

{ #category : #'visiting terms' }
CopyingVisitor >> messageFunctorVisit: term [
	"For convenience this method will by default forward the message request to multiPartFunctorVisit: as the visitor's behavior for keyword en message functors will in most cases be the same"

	
	^self multiPartFunctorVisit: term
]

{ #category : #'visiting terms' }
CopyingVisitor >> multiPartFunctorVisit: aFunctor [
	"See comment in keywordFunctorVisit: and messageFunctorVisit:"

	
	^aFunctor class
		keywords: (aFunctor keywords collect: [:keyword | keyword accept: self])
]

{ #category : #'visiting clauses' }
CopyingVisitor >> nativeClauseVisit: aClause [
	
	^aClause class newWith: (aClause header accept: self)
]

{ #category : #'visiting terms' }
CopyingVisitor >> objectVisit: anObject [
	"By default this will *not* copy the upped object, just the term itself"

	
	^anObject class up: anObject smalltalkValue
]

{ #category : #'visiting clauses' }
CopyingVisitor >> queryVisit: aClause [
	
	| copy |
	copy := SoulFactory current makeQuery
		condition: (aClause condition accept: self).
	copy comment: aClause comment.
	^copy
]

{ #category : #'visiting terms' }
CopyingVisitor >> quotedCodeTermVisit: aQuotedCodeBlock [
	"TODO: this wont work if we use the copyingvisitor to write a renaming tool for variables for example ..."

	
	^aQuotedCodeBlock class source: aQuotedCodeBlock source
]

{ #category : #'visiting terms' }
CopyingVisitor >> resultMessageTermVisit: rmTerm [
	
	^SoulFactory current makeResultMessageTerm
		message: (rmTerm message accept: self)
		result: (rmTerm result accept: self)
]

{ #category : #'visiting clauses' }
CopyingVisitor >> ruleVisit: aClause [
	
	| copy |
	copy := SoulFactory current makeRule
		condition: (aClause condition accept: self)
		conclusion: (aClause conclusion accept: self).
	copy comment: aClause comment.
	^copy
]

{ #category : #'visiting terms' }
CopyingVisitor >> smalltalkTermVisit: anSTTerm [
	"TODO: this might not work properly if we use the copyingvisitor to write a renaming tool for variables for example ..."

	"UGLY: yukky type test here"

	
	^anSTTerm class
		source: anSTTerm source
		variables:
			(anSTTerm variablesIncludingNils
				collect:
					[:x | 
					(x isKindOf: AbstractTerm)
						ifTrue: [x accept: self]
						ifFalse: [x]])
		content: anSTTerm content
		block: anSTTerm block
]

{ #category : #'visiting terms' }
CopyingVisitor >> templateQueryTermVisit: aTemplateQueryTerm [
	"TODO: this wont work if we use the copyingvisitor to write a renaming tool for variables for example ..."

	
	^aTemplateQueryTerm class
		source: aTemplateQueryTerm source
		type: aTemplateQueryTerm type
]

{ #category : #'visiting terms' }
CopyingVisitor >> termSequenceVisit: aTermSequence [
	
	^aTermSequence class
		terms: (aTermSequence terms collect: [:subTerm | subTerm accept: self])
]

{ #category : #'visiting terms' }
CopyingVisitor >> unaryMessageFunctorVisit: unaryMessageFunctor [
	
	^unaryMessageFunctor class
		message: (unaryMessageFunctor message accept: self)
]

{ #category : #'visiting terms' }
CopyingVisitor >> underscoreVariableVisit: aVariable [
	
	^aVariable class name: aVariable name
]

{ #category : #'visiting terms' }
CopyingVisitor >> variableVisit: aVariable [
	
	^(aVariable class name: aVariable name) setAddress: aVariable address
]

{ #category : #'visiting terms' }
CopyingVisitor >> visitAnnotatedTerm: aTerm [
	
	^aTerm class
		term: (aTerm term accept: self)
		annotation: (aTerm annotation accept: self)
]
