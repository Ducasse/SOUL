Class {
	#name : #AnnotatedTerm,
	#superclass : #ResolvableTerm,
	#instVars : [
		'term',
		'annotation'
	],
	#category : 'SOUL-GrammarTerms'
}

{ #category : #'instance creation' }
AnnotatedTerm class >> term: aTerm annotation: anAnnotationTerm [
	
	^(super new)
		term: aTerm annotation: anAnnotationTerm;
		yourself
]

{ #category : #visitor }
AnnotatedTerm >> accept: aVisitor [
	
	^aVisitor visitAnnotatedTerm: self
]

{ #category : #'annotated terms' }
AnnotatedTerm >> annotation [
	
	^annotation
]

{ #category : #delegation }
AnnotatedTerm >> doesNotUnderstand: aMessage [
	
	self halt.
	^term
		perform: aMessage selector
		withArguments: aMessage arguments
]

{ #category : #access }
AnnotatedTerm >> functor [
	
	^self term functor
]

{ #category : #access }
AnnotatedTerm >> innerTerm [
	
	^term innerTerm
]

{ #category : #testing }
AnnotatedTerm >> isAnnotatedTerm [
	
	^true
]

{ #category : #testing }
AnnotatedTerm >> isCallTerm [
	
	^false	"	^ term isCallTerm"
]

{ #category : #testing }
AnnotatedTerm >> isConstantFunctor [
	
	^false	"^ term isConstantFunctor"
]

{ #category : #testing }
AnnotatedTerm >> isIndexable [
	
	^false	"^ term isIndexable"
]

{ #category : #testing }
AnnotatedTerm >> isKeywordFunctor [
	
	^false	"^ term isKeywordFunctor"
]

{ #category : #testing }
AnnotatedTerm >> isMessageFunctor [
	
	^false	"
	^ term isMessageFunctor"
]

{ #category : #testing }
AnnotatedTerm >> isNative [
	
	^false	"^ term isNative"
]

{ #category : #testing }
AnnotatedTerm >> isUnaryMessageFunctor [
	
	^false	"^ term isUnaryMessageFunctor"
]

{ #category : #testing }
AnnotatedTerm >> isVariable [
	
	^false	"^ term isVariable"
]

{ #category : #resolving }
AnnotatedTerm >> lexicalAddressInEnv: anEnv startAt: anIndex ifAbsent: aBlock [
	
	^super lexicalAddressInEnv: anEnv startAt: anIndex ifAbsent: aBlock	"^term lexicalAddressInEnv: anEnv startAt: anIndex ifAbsent: aBlock"
]

{ #category : #access }
AnnotatedTerm >> multiplicity [
	
	^term multiplicity
]

{ #category : #access }
AnnotatedTerm >> predicate [
	"Necessary in order to store clauses with annotated head in repository."

	
	^term predicate
]

{ #category : #resolving }
AnnotatedTerm >> predicateInEnv: anEnv startAt: anIndex [
	"	^term predicateInEnv: anEnv startAt: anIndex	"

	
	^term predicateInEnv: anEnv startAt: anIndex
]

{ #category : #printing }
AnnotatedTerm >> prettyPrintOn: aStream scope: id [
	
	term prettyPrintOn: aStream scope: id.
	aStream
		withAttributes:
			(Array
				with: TextColor red
				with: TextEmphasis bold) do:[
	aStream write: ' : '].
	annotation prettyPrintOn: aStream scope: id
]

{ #category : #printing }
AnnotatedTerm >> printForCompileOn: aStream [
	
	aStream write: self class name , ' term: ('.
	term printForCompileOn: aStream.
	aStream write: ') annotation: ('.
	annotation printForCompileOn: aStream.
	aStream write: ')'
]

{ #category : #printing }
AnnotatedTerm >> printOn: aStream [
	"see comment in AbstractTerm"

	
	term printOn: aStream.
	aStream write: ' : '.
	annotation printOn: aStream
]

{ #category : #access }
AnnotatedTerm >> recursiveDefinitionRepository: aRepository [
	
	self definitionRepository: aRepository.
	term recursiveDefinitionRepository: aRepository.
	annotation recursiveDefinitionRepository: aRepository
]

{ #category : #resolving }
AnnotatedTerm >> resolveIn: env startAt: anIndex [
	
	^term resolveIn: env startAt: anIndex
]

{ #category : #access }
AnnotatedTerm >> term [
	
	^term
]

{ #category : #access }
AnnotatedTerm >> term: anObject [
	
	term := anObject
]

{ #category : #'initialize-release' }
AnnotatedTerm >> term: aTerm annotation: anAnnotationTerm [
	
	term := aTerm.
	annotation := anAnnotationTerm
]

{ #category : #reification }
AnnotatedTerm >> transitiveLookupIn: anEnv startAt: anIndex [
	
	| newterm newAnnotation |
	newAnnotation := annotation transitiveLookupIn: anEnv startAt: anIndex.
	newterm := term transitiveLookupIn: anEnv startAt: anIndex.
	^(self class term: newterm annotation: newAnnotation)
		definitionRepository: self definitionRepository
]

{ #category : #unification }
AnnotatedTerm >> unifyWith: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"see comment in AbstractTerm"

	
	^aTerm
		unifyWithAnnotatedTerm: self
		inEnv: anEnv
		myIndex: hisIndex
		hisIndex: myIndex
		inSource: (inSource xor: true)
]

{ #category : #unification }
AnnotatedTerm >> unifyWithAnnotatedTerm: aTerm inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource [
	
	^(self term
		unifyWith: aTerm term
		inEnv: anEnv
		myIndex: sourceIndex
		hisIndex: targetIndex
		inSource: inSource)
		and:
			[self annotation
				unifyWith: aTerm annotation
				inEnv: anEnv
				myIndex: sourceIndex
				hisIndex: targetIndex
				inSource: inSource]
]

{ #category : #unification }
AnnotatedTerm >> unifyWithCompoundTerm: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	^aTerm
		unifyWithAnnotatedTerm: self
		inEnv: anEnv
		myIndex: hisIndex
		hisIndex: myIndex
		inSource: (inSource xor: true)
]

{ #category : #unification }
AnnotatedTerm >> unifyWithVariable: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	^aTerm
		unifyWithAnnotatedTerm: self
		inEnv: anEnv
		myIndex: hisIndex
		hisIndex: myIndex
		inSource: (inSource xor: true)
]

{ #category : #access }
AnnotatedTerm >> usesPredicate: aPredicate multiplicity: aNumber [
	
	^(term usesPredicate: aPredicate multiplicity: aNumber)
		or: [annotation usesPredicate: aPredicate multiplicity: aNumber]
]
