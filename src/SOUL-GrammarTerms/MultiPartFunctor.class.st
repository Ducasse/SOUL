Class {
	#name : #MultiPartFunctor,
	#superclass : #AbstractTerm,
	#instVars : [
		'keywords'
	],
	#category : 'SOUL-GrammarTerms'
}

{ #category : #'instance creation' }
MultiPartFunctor class >> keyword: keyword [
	
	^self new keyword: keyword
]

{ #category : #'instance creation' }
MultiPartFunctor class >> keywords: keywords [
	
	^self new keywords: keywords
]

{ #category : #'instance creation' }
MultiPartFunctor class >> name: aName [
	
	^self
		keywords:
			(aName asSymbol keywords
				collect:
					[:keywordName | SoulFactory current makeConstant name: (keywordName allButLast: 1) asSymbol])
]

{ #category : #parsing }
MultiPartFunctor >> addKeyword: keyword [
	
	keywords addFirst: keyword
]

{ #category : #converting }
MultiPartFunctor >> asPredicateNameInEnv: anEnv startAt: idx [
	"UGLY: the recursive sending of asPredicateNameInEnv might be better replaced with a new message, asKeywordInEnv ..."

	
	^self keywords
		inject: ''
		into:
			[:predicateName :keyword | predicateName , (keyword asPredicateNameInEnv: anEnv startAt: idx) , ':']
]

{ #category : #testing }
MultiPartFunctor >> isIndexable [
	
	self keywords
		detect: [:keyword | keyword isKindOf: Variable]
		ifNone: [^true].
	^false
]

{ #category : #initializing }
MultiPartFunctor >> keyword: keyword [
	
	keywords := OrderedCollection with: keyword
]

{ #category : #accessing }
MultiPartFunctor >> keywords [
	
	^keywords
]

{ #category : #initializing }
MultiPartFunctor >> keywords: keys [
	
	keywords := keys
]

{ #category : #accessing }
MultiPartFunctor >> multiplicity [
	
	self subclassResponsibility
]

{ #category : #accessing }
MultiPartFunctor >> name [
	
	^(keywords
		inject: ''
		into: [:concatenated :keyword | concatenated , keyword name , ':'])
		asSymbol
]

{ #category : #printing }
MultiPartFunctor >> printAsPrologFunctorOn: aStream scope: id in: env startAt: idx [
	"TODO: What if any of the keywords are variables?"

	
	self keywords
		do: [:keyword | aStream write: keyword name]
		separatedBy: [aStream write: '_']	"Clearer without the last underscore, but potential ambiguity between unary messages and keyword messages with one argument. Uncomment if unambigous translation is needed"
	"aStream write: '_'."
]

{ #category : #printing }
MultiPartFunctor >> printForCompileOn: aStream [
	"see comment in AbstractTerm"

	
	aStream write: self class name , ' keywords: (OrderedCollection new '.
	self keywords
		do:
			[:keyword | 
			aStream write: 'add:('.
			keyword printForCompileOn: aStream.
			aStream write: ')']
		separatedBy: [aStream write: ';'].
	aStream write: ';yourself)'
]

{ #category : #printing }
MultiPartFunctor >> printOn: aStream [
	
	keywords
		do:
			[:keyword | 
			keyword printOn: aStream.
			aStream write: ':']
]

{ #category : #scoping }
MultiPartFunctor >> recursiveDefinitionRepository: aRepository [
	"see comment in AbstractTerm"

	
	self definitionRepository: aRepository.
	keywords
		do: [:keyword | keyword recursiveDefinitionRepository: aRepository]
]

{ #category : #reification }
MultiPartFunctor >> transitiveLookupIn: anEnv startAt: anIndex [
	
	^self class
		keywords:
			(keywords
				collect:
					[:keyword | keyword transitiveLookupIn: anEnv startAt: anIndex])
]
