"
This class represents simple logic constants. In SOUL these are actually the same as Smalltalk Symbols (wrapped in Upped Objects). This class specializes the upped Smalltalk symbols a little for pretty printing and some other stuff


"
Class {
	#name : #Constant,
	#superclass : #UppedObject,
	#category : 'SOUL-GrammarTerms'
}

{ #category : #'instance creation' }
Constant class >> name: aSymbol [
	
	^self new setName: aSymbol
]

{ #category : #visitor }
Constant >> accept: aVisitor [
	"see comment in AbstractTerm"

	
	^aVisitor constantVisit: self
]

{ #category : #converting }
Constant >> asPredicateNameInEnv: anEnv startAt: anIndex [
	"see comment in AbstractTerm"

	
	^self name asString
]

{ #category : #access }
Constant >> functor [
	
	^self
]

{ #category : #testing }
Constant >> isConstantFunctor [
	
	^true
]

{ #category : #access }
Constant >> name [
	"return the name of the constant"

	
	^smalltalkValue
]

{ #category : #converting }
Constant >> predicate [
	"see comment in AbstractTerm"

	
	^self asPredicateNameInEnv: nil startAt: nil
]

{ #category : #resolving }
Constant >> predicateInEnv: anEnv startAt: anIndex [
	"see comment in AbstractTerm"

	
	^self asPredicateNameInEnv: anEnv startAt: anIndex
]

{ #category : #printing }
Constant >> printAsPrologOn: aStream scope: id in: env startAt: idx [
	
	self smalltalkValue printAsPrologOn: aStream scope: id in: env startAt:
			idx	"smalltalkValue printAsPrologOn: aStream scope: id"
]

{ #category : #printing }
Constant >> printForCompileOn: aStream [
	"see comment in AbstractTerm"

	
	| x name |
	aStream write: self class name , ' name: #'''.	"I should first convert every quote into a double quote"

	name := smalltalkValue asString.
	1
		to: name size
		do:
			[:i | 
			aStream write: (x := name at: i).
			x == $' ifTrue: [aStream write: x]].
	aStream write: ''''
]

{ #category : #printing }
Constant >> printOn: aStream [
	"see comment in AbstractTerm"

	
	| stringRepresentation |
	stringRepresentation := smalltalkValue asString.
	(stringRepresentation includes: $:) ifTrue: [aStream write: '#'].
	aStream write: smalltalkValue asString
]

{ #category : #resolving }
Constant >> resolveIn: env startAt: anIndex [
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
		multiplicity: 0.
	^SoulFactory current makeResolver fromClause: self toClauses: foundClauses
		inEnv: env startAt: anIndex
]

{ #category : #initialize }
Constant >> setName: aSymbol [
	"initialize a constant. aSymbol can also contain an integer, in that case we must make it an integer"

	
	aSymbol isAllDigits
		ifTrue: [self setSmalltalkValue: aSymbol asNumber asInteger]
		ifFalse: [self setSmalltalkValue: aSymbol]
]

{ #category : #unification }
Constant >> unifyWithListTerm: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	^false
]

{ #category : #access }
Constant >> usesPredicate: aPredicate multiplicity: aNumber [
	"See comment in AbstractTerm"

	
	self name isString
		ifTrue: [^self predicate = aPredicate & (self multiplicity = aNumber)].
	^false
]
