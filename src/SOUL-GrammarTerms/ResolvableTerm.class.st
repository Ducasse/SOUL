Class {
	#name : #ResolvableTerm,
	#superclass : #AbstractTerm,
	#instVars : [
		'lexicalAddress'
	],
	#category : 'SOUL-GrammarTerms'
}

{ #category : #resolving }
ResolvableTerm >> clauseNotFoundIn: repository inEnv: env startAt: anIndex [
	
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
					'Cannot resolve ' , self asString , ' in repository ' , repository name]
]

{ #category : #private }
ResolvableTerm >> dynamicPredicate: aPredicate inEnv: anEnv startAt: anIndex [
	
	| evaluator result |
	(self definitionRepository addressForPredicate: 'dynamic')
		ifNil: [^false]
		ifNotNil:
			[evaluator := SoulFactory current evaluatorForLogicQuery
				eval: 'if dynamic(#' , aPredicate , ')'
				in: self definitionRepository.
			result := evaluator nextResult.
			^result success]
]

{ #category : #access }
ResolvableTerm >> lexicalAddress [
	
	^lexicalAddress
]

{ #category : #private }
ResolvableTerm >> lexicalAddress: anObject [
	
	lexicalAddress := anObject.
	lexicalAddress = 0 ifTrue: [self halt]
]

{ #category : #resolving }
ResolvableTerm >> lexicalAddressInEnv: anEnv startAt: anIndex ifAbsent: aBlock [
	
	^self
		lexicalAddressInEnv: anEnv
		startAt: anIndex
		repository: self definitionRepository
		ifAbsent: aBlock
]

{ #category : #resolving }
ResolvableTerm >> lexicalAddressInEnv: anEnv startAt: anIndex repository: aRep ifAbsent: aBlock [
	"Lookup the address of the predicate of this clause in the database"

	
	| addr index |
	addr := self lexicalAddress.
	^addr
		ifNil:
			[index := aRep
				addressForPredicate: (self predicateInEnv: anEnv startAt: anIndex).
			index
				ifNil: aBlock
				ifNotNil: [index]]
		ifNotNil: [addr]
]

{ #category : #resolving }
ResolvableTerm >> resolveIn: env startAt: anIndex [
	"resolve as a normal term: do lookup in repository and create a resolver  on it"

	
	| foundClauses |
	foundClauses := self definitionRepository
		normalAddressLookup:
			(self
				lexicalAddressInEnv: env
				startAt: anIndex
				ifAbsent:
					[^self
						clauseNotFoundIn: self definitionRepository
						inEnv: env
						startAt: anIndex])
		multiplicity: self multiplicity.
	^SoulFactory current makeResolver fromClause: self toClauses: foundClauses
		inEnv: env startAt: anIndex
]
