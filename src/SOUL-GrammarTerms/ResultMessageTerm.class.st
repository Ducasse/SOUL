Class {
	#name : #ResultMessageTerm,
	#superclass : #ResolvableTerm,
	#instVars : [
		'messageTerm',
		'resultTerm'
	],
	#category : 'SOUL-GrammarTerms'
}

{ #category : #'instance creation' }
ResultMessageTerm class >> message: message result: result [
	
	^self new message: message result: result
]

{ #category : #visitor }
ResultMessageTerm >> accept: visitor [
	
	^visitor resultMessageTermVisit: self
]

{ #category : #accessing }
ResultMessageTerm >> arguments [
	
	^messageTerm termSequence terms allButFirst: 1
]

{ #category : #accessing }
ResultMessageTerm >> functor [
	
	^messageTerm functor
]

{ #category : #misc }
ResultMessageTerm >> lexicalAddressInEnvNoEquals: anEnv startAt: idx ifAbsent: absentBlock [
	
	^messageTerm lexicalAddressInEnv: anEnv startAt: idx ifAbsent: absentBlock
]

{ #category : #accessing }
ResultMessageTerm >> message [
	
	^messageTerm
]

{ #category : #initialization }
ResultMessageTerm >> message: message result: result [
	
	messageTerm := message.
	resultTerm := result
]

{ #category : #accessing }
ResultMessageTerm >> multiplicity [
	
	^messageTerm multiplicity + 1
]

{ #category : #misc }
ResultMessageTerm >> predicate [
	
	^(messageTerm predicateInEnv: nil startAt: nil) , '='
]

{ #category : #misc }
ResultMessageTerm >> predicateInEnv: anEnv startAt: idx [
	
	^(messageTerm predicateInEnv: anEnv startAt: idx) , '='
]

{ #category : #printing }
ResultMessageTerm >> prettyPrintOn: aStream scope: scope [
	
	messageTerm prettyPrintOn: aStream scope: scope.
	aStream withAttribute:(TextColor green) do:[
	aStream nextPutAll: ' = '].
	resultTerm prettyPrintOn: aStream scope: scope.

]

{ #category : #printing }
ResultMessageTerm >> printAsPrologOn: aStream scope: id in: env startAt: idx [
	
	messageTerm functor printAsPrologFunctorOn: aStream scope: #asTerm in: env
		startAt: idx.
	aStream write: '('.
	messageTerm termSequence printAsPrologOn: aStream scope: #asTerm in: env
		startAt: idx.
	aStream write: ')'
]

{ #category : #printing }
ResultMessageTerm >> printForCompileOn: aStream [
	
	aStream nextPutAll: self class name , ' message: ('.
	messageTerm printForCompileOn: aStream.
	aStream nextPutAll: ') result: ('.
	resultTerm printForCompileOn: aStream.
	aStream nextPutAll: ')'
]

{ #category : #printing }
ResultMessageTerm >> printOn: aStream [
	
	messageTerm printOn: aStream.
	aStream nextPutAll: ' = '.
	resultTerm printOn: aStream
]

{ #category : #'As yet unclassified' }
ResultMessageTerm >> receiver [
	
	^messageTerm termSequence terms first
]

{ #category : #scoping }
ResultMessageTerm >> recursiveDefinitionRepository: aRepository [
	"see comment in AbstractTerm"

	
	self definitionRepository: aRepository.
	messageTerm recursiveDefinitionRepository: aRepository.
	resultTerm recursiveDefinitionRepository: aRepository
]

{ #category : #resolving }
ResultMessageTerm >> resolveIn: env startAt: anIndex [
	"resolve as a normal term: do lookup in repository and create a resolver  on it"

	
	| foundClauses multiplicity address |
	multiplicity := self multiplicity.
	address := self
		lexicalAddressInEnv: env
		startAt: anIndex
		ifAbsent:
			[multiplicity := multiplicity - 1.
			self
				lexicalAddressInEnvNoEquals: env
				startAt: anIndex
				ifAbsent:
					[^self
						clauseNotFoundIn: self definitionRepository
						inEnv: env
						startAt: anIndex]].
	foundClauses := self definitionRepository normalAddressLookup: address
		multiplicity: multiplicity.
	^SoulFactory current makeResolver fromClause: self toClauses: foundClauses
		inEnv: env startAt: anIndex
]

{ #category : #accessing }
ResultMessageTerm >> result [
	
	^resultTerm
]

{ #category : #accessing }
ResultMessageTerm >> selector [
	
	^messageTerm functor name
]

{ #category : #accessing }
ResultMessageTerm >> termSequence [
	
	^SoulFactory current makeTermSequence
		terms:
			((messageTerm termSequence terms copy)
				add: resultTerm;
				yourself)
]

{ #category : #unification }
ResultMessageTerm >> unifyWith: aTerm inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource [
	"double dispatch the unification of the term"
	
	^aTerm unifyWithResultMessageTerm: self inEnv: anEnv myIndex: targetIndex
		hisIndex: sourceIndex inSource: inSource
]

{ #category : #unification }
ResultMessageTerm >> unifyWithCompoundTerm: aCompound inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	^(self result
		unifyWith: true soulUp
		inEnv: anEnv
		myIndex: myIndex
		hisIndex: hisIndex
		inSource: inSource)
		and:
			[self message unifyWithCompoundTerm: aCompound inEnv: anEnv myIndex:
					myIndex hisIndex: hisIndex inSource: inSource]
]

{ #category : #unification }
ResultMessageTerm >> unifyWithResultMessageTerm: aRM inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource [
	^(messageTerm
		unifyWith: aRM message
		inEnv: anEnv
		myIndex: sourceIndex
		hisIndex: targetIndex
		inSource: inSource)
		and:
			[resultTerm
				unifyWith: aRM result
				inEnv: anEnv
				myIndex: sourceIndex
				hisIndex: targetIndex
				inSource: inSource]
]

{ #category : #unification }
ResultMessageTerm >> unifyWithVariable: aVariable inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"we group all unfication with variables in the Variable class"

	
	^aVariable
		unifyWithResultMessageTerm: self
		inEnv: anEnv
		myIndex: hisIndex
		hisIndex: myIndex
		inSource: (inSource xor: true)
]
