"
This class represent the CallTerm logic term. Call terms are logic terms that are called inside another repository than the one where they are defined. The syntax is:

?repvar->callterm(anything)
"
Class {
	#name : #CallTerm,
	#superclass : #ResolvableTerm,
	#instVars : [
		'variable',
		'normalterm'
	],
	#category : 'SOUL-GrammarTerms'
}

{ #category : #'instance creation' }
CallTerm class >> variable: aVariable term: aTerm [
	
	^self new variable: aVariable term: aTerm
]

{ #category : #visitor }
CallTerm >> accept: aVisitor [
	"see comment in AbstractTerm"

	
	^aVisitor callTermVisit: self
]

{ #category : #converting }
CallTerm >> asNormalTerm [
	"Convert the callterm to a normalterm simply by returning its normalterm inside"

	
	^normalterm
]

{ #category : #private }
CallTerm >> callRepositoryInEnv: anEnv startAt: anIndex [
	
	| localValue |
	localValue := variable soulDownIn: anEnv startAt: anIndex.
	^localValue = variable
		ifTrue: [self definitionRepository lookupBindingFor: variable]
		ifFalse: [localValue]
]

{ #category : #resolving }
CallTerm >> clauseNotFoundIn: repository inEnv: env startAt: anIndex [
	
	(self
		dynamicPredicate: (self predicateInEnv: env startAt: anIndex)
		inEnv: env
		startAt: anIndex)
		ifTrue:
			[^SoulFactory current makeNativeResolver
				onBlock: [:res | res]
				withArguments: #(nil)]
		ifFalse:
			[self
				error:
					'Cannot resolve ' , self normalterm asString , ' in repository '
						, repository name]
]

{ #category : #access }
CallTerm >> definitionRepository: aRepository [
	"See comment in AbstractTerm"

	
	definitionRepository := aRepository.
	normalterm definitionRepository: aRepository
]

{ #category : #private }
CallTerm >> dynamicPredicate: aPredicate inEnv: anEnv startAt: anIndex [
	
	| evaluator result resRep |
	resRep := self callRepositoryInEnv: anEnv startAt: anIndex.
	(resRep addressForPredicate: 'dynamic')
		ifNil: [^false]
		ifNotNil:
			[evaluator := SoulFactory current evaluatorForLogicQuery
				eval: 'if dynamic(' , aPredicate , ')'
				in: self definitionRepository.
			result := evaluator nextResult.
			^result success]
]

{ #category : #testing }
CallTerm >> isCallTerm [
	
	^true
]

{ #category : #access }
CallTerm >> multiplicity [
	
	^normalterm multiplicity
]

{ #category : #access }
CallTerm >> normalterm [
	
	^normalterm
]

{ #category : #access }
CallTerm >> predicate [
	
	| normalPredicate |
	normalPredicate := normalterm predicate.
	^normalPredicate == nil
		ifTrue: [nil]
		ifFalse: ['Q' , variable name , normalterm predicate]
]

{ #category : #resolving }
CallTerm >> predicateInEnv: anEnv startAt: anIndex [
	
	^self normalterm predicateInEnv: anEnv startAt: anIndex
]

{ #category : #printing }
CallTerm >> printForCompileOn: aStream [
	"see comment in AbstractTerm"

	
	aStream write: self class name , ' variable: ('.
	variable printForCompileOn: aStream.
	aStream write: ') term: ('.
	normalterm printForCompileOn: aStream.
	aStream write: ')'
]

{ #category : #printing }
CallTerm >> printOn: aStream [
	"see comment in AbstractTerm"

	
	variable printOn: aStream.
	aStream write: '->'.
	normalterm printOn: aStream
]

{ #category : #resolving }
CallTerm >> resolveIn: anEnv startAt: anIndex [
	"resolve as a normal clause: do lookup in repository and create a  
	resolver on it"

	
	| foundClauses resRep |
	resRep := self callRepositoryInEnv: anEnv startAt: anIndex.
	resRep compile.
	normalterm recursiveDefinitionRepository: resRep.
	foundClauses := resRep
		normalAddressLookup:
			(normalterm
				lexicalAddressInEnv: anEnv
				startAt: anIndex
				repository: resRep
				ifAbsent:
					[^self clauseNotFoundIn: resRep inEnv: anEnv startAt: anIndex])
		multiplicity: self multiplicity.
	^Resolver fromClause: normalterm toClauses: foundClauses inEnv: anEnv
		startAt: anIndex
]

{ #category : #access }
CallTerm >> usesPredicate: aPredicate multiplicity: aNumber [
	"See comment in AbstractTerm"

	
	^normalterm usesPredicate: aPredicate multiplicity: aNumber
]

{ #category : #access }
CallTerm >> variable [
	
	^variable
]

{ #category : #initialize }
CallTerm >> variable: aVariable term: aTerm [
	"A callterm contains a normalterm and a repository variable"

	
	variable := aVariable.
	normalterm := aTerm
]
