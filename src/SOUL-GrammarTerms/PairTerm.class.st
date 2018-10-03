"
collect
	
	|newCollection|
	newCollection := OrderedCollection new.
	self listDo: [:elt | newCollection add: elt ].
	^newCollection
"
Class {
	#name : #PairTerm,
	#superclass : #ListTerm,
	#category : 'SOUL-GrammarTerms'
}

{ #category : #parsing }
PairTerm >> addChildrenInitial: aCollection [
	"this is called by the parser to construct a parsetree"

	"aCollection is een Collection die een QSOULTermSequence bevat"

	
	| holdFirst holdSecond |
	holdSecond := aCollection last.
	aCollection first
		reverseDo:
			[:X | 
			| holdCollection |
			holdFirst := X.
			holdCollection := OrderedCollection with: holdFirst with: holdSecond.
			holdSecond := self makeListCompound: holdCollection].
	^self
		setFunctor: holdSecond functor
		setTermSequence: holdSecond termSequence
]

{ #category : #enumeration }
PairTerm >> collectIn: anEnv startAt: anIndex [
	
	| newCollection |
	newCollection := OrderedCollection new.
	newCollection
		add: (termsequence terms first soulDownIn: anEnv startAt: anIndex).
	newCollection
		addAll:
			((termsequence terms last soulDownIn: anEnv startAt: anIndex) collectIn:
					anEnv startAt: anIndex).
	^newCollection
]

{ #category : #printing }
PairTerm >> printAsPrologOn: aStream scope: id in: env startAt: idx [
	"see comment in AbstractTerm"

	
	aStream write: '['.
	termsequence terms first printAsPrologOn: aStream scope: id in: env
		startAt: idx.
	termsequence terms last isVariable
		ifTrue:
			[aStream write: '|'.
			termsequence terms last printAsPrologOn: aStream scope: id in: nil
				startAt: nil]
		ifFalse:
			[termsequence terms last printAsPrologListOn: aStream scope: id in: nil
				startAt: nil].
	aStream write: ']'
]
