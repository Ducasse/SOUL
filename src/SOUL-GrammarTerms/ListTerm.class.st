"
Represent a list term. They are simulated through compound terms, which is why it's a subclass of it.


"
Class {
	#name : #ListTerm,
	#superclass : #CompoundTerm,
	#category : 'SOUL-GrammarTerms'
}

{ #category : #constants }
ListTerm class >> ListTermFunctor [
	"What kind of functor will we use to simulate lists as compound terms? "

	
	^SoulFactory current makeConstant name: #'.'
]

{ #category : #'instance creation' }
ListTerm class >> newFromCollection: aCollection [
	
	^self new
		addChildrenInitial:
			(OrderedCollection
				with: (TermSequence terms: (aCollection asOrderedCollection collect: [:e | e soulUp])))
]

{ #category : #'instance creation' }
ListTerm class >> termSequence: aTermSequence [
	
	^self new addChildrenInitial: (OrderedCollection with: aTermSequence)
]

{ #category : #constants }
ListTerm >> ListTermFunctor [
	"What kind of functor will we use to simulate lists as compound terms?"

	
	^SoulFactory current makeConstant name: #'.'
]

{ #category : #visitor }
ListTerm >> accept: aVisitor [
	"see comment in AbstractTerm"

	
	^aVisitor listTermVisit: self
]

{ #category : #parsing }
ListTerm >> addChildrenInitial: aCollection [
	"this method is called by the parser to construct a parsetree"

	"lists are simulated by compounds containing the head of the list as one 
	subterm and a listterm (compound) containing the rest of the list"

	"aCollection is a Collection that contains a TermSequence"

	
	| holdFirst holdSecond |
	holdSecond := EmptyListConstant new.
	aCollection first
		reverseDo:
			[:X | 
			| holdCollection |
			holdFirst := X.
			holdCollection := OrderedCollection with: holdFirst with: holdSecond.
			holdSecond := self makeListCompound: holdCollection].
	aCollection first size = 0
		ifTrue: [^holdSecond]
		ifFalse:
			[^self
				setFunctor: holdSecond functor
				setTermSequence: holdSecond termSequence]
]

{ #category : #converting }
ListTerm >> asDCGConditionFor: counter [
	
	| tokens1var tokens2var pairterm terminals |
	terminals := OrderedCollection new.
	self listDo: [:aTerm | terminals add: aTerm].
	tokens1var := SoulFactory current makeVariable
		name: 'tokens' , counter asString.
	tokens2var := SoulFactory current makeVariable
		name: 'tokens' , (counter + 1) asString.
	pairterm := SoulFactory current makePair new
		addChildrenInitial:
			(OrderedCollection
				with: (TermSequence terms: terminals)
				with: tokens2var).
	^SoulFactory current makeCompound
		functor: (Constant name: #equals)
		termSequence:
			(TermSequence terms: (OrderedCollection with: tokens1var with: pairterm))
]

{ #category : #access }
ListTerm >> astLink: anASTLink [
	
	astlink := anASTLink
]

{ #category : #enumeration }
ListTerm >> collectIn: anEnv startAt: anIndex [
	
	| newCollection |
	newCollection := OrderedCollection new.
	self
		listDo:
			[:elt | newCollection add: (elt soulDownIn: anEnv startAt: anIndex)].
	^newCollection
]

{ #category : #enumeration }
ListTerm >> listDo: aBlock [
	
	aBlock value: termsequence terms first.
	termsequence terms last listDo: aBlock
]

{ #category : #printing }
ListTerm >> listPrintOn: aStream [
	"this method is called when we are printed inside another list"

	
	aStream write: ','.
	termsequence terms first printOn: aStream.
	(termsequence terms last isKindOf: ListTerm)
		| (termsequence terms last isKindOf: EmptyListConstant)
		ifTrue: [termsequence terms last listPrintOn: aStream]
		ifFalse:
			[aStream write: '|'.
			termsequence terms last printOn: aStream]
]

{ #category : #parsing }
ListTerm >> makeListCompound: aCollection [
	"this is a help method for the parsetree construction"

	
	^self class
		functor: self class ListTermFunctor
		termSequence: (TermSequence terms: aCollection)
]

{ #category : #printing }
ListTerm >> prettyListPrintOn: aStream scope: id [
	"this method is called when we are printed inside another list"

	
	aStream write: ','.
	termsequence terms first prettyPrintOn: aStream scope: id.
	(termsequence terms last isKindOf: ListTerm)
		| (termsequence terms last isKindOf: EmptyListConstant)
		ifTrue: [termsequence terms last prettyListPrintOn: aStream scope: id]
		ifFalse:
			[aStream write: '|'.
			termsequence terms last prettyPrintOn: aStream scope: id]
]

{ #category : #printing }
ListTerm >> prettyPrintOn: aStream scope: id [
	"see comment in AbstractTerm"

	
	aStream write: '<'.
	termsequence terms first prettyPrintOn: aStream scope: id.
	(termsequence terms last isKindOf: ListTerm)
		| (termsequence terms last isKindOf: EmptyListConstant)
		ifTrue: [termsequence terms last prettyListPrintOn: aStream scope: id]
		ifFalse:
			[aStream write: '|'.
			termsequence terms last prettyPrintOn: aStream scope: id].
	aStream write: '>'
]

{ #category : #printing }
ListTerm >> printAsPrologListOn: aStream scope: id in: env startAt: idx [
	"this method is called when we are printed inside another list"

	
	aStream write: ','.
	termsequence terms first printAsPrologOn: aStream scope: id in: env
		startAt: idx.
	termsequence terms last species == SoulFactory current makeVariable
		ifTrue:
			[aStream write: '|'.
			termsequence terms last printAsPrologOn: aStream scope: id in: env
				startAt: idx]
		ifFalse:
			[termsequence terms last printAsPrologListOn: aStream scope: id in: env
				startAt: idx]
]

{ #category : #printing }
ListTerm >> printAsPrologOn: aStream scope: scope in: env startAt: idx [
	"see comment in AbstractTerm"

	
	aStream write: '['.
	termsequence terms first printAsPrologOn: aStream scope: #clause in: env
		startAt: idx.
	termsequence terms last printAsPrologListOn: aStream scope: #clause in:
			nil startAt: nil.
	aStream write: ']'
]

{ #category : #printing }
ListTerm >> printOn: aStream [
	"see comment in AbstractTerm"

	
	aStream write: '<'.
	termsequence terms first printOn: aStream.
	(termsequence terms last isKindOf: ListTerm)
		| (termsequence terms last isKindOf: EmptyListConstant)
		ifTrue: [termsequence terms last listPrintOn: aStream]
		ifFalse:
			[aStream write: '|'.
			termsequence terms last printOn: aStream].
	aStream write: '>'
]

{ #category : #resolving }
ListTerm >> resolveIn: anEnv startAt: anIndex [
	"See comment in AbstractTerm"

	
	self error: 'Cannot resolve a ' , self class asString
]

{ #category : #initialize }
ListTerm >> setFunctor: aFunctor setTermSequence: aTermSequence [
	"initialization of the compound"

	
	functor := aFunctor.
	termsequence := aTermSequence.
	astlink := nil
]

{ #category : #reification }
ListTerm >> soulDownIn: anEnv startAt: anIndex [
	"downing a compoundterm means downing myself and downing my  
	subterms. HOWEVER: We must up the subterms because they are  
	included in a listterm"

	
	| newTermSequence |
	newTermSequence := termsequence soulDownIn: anEnv startAt: anIndex.
	^self class functor: functor termSequence: newTermSequence
]

{ #category : #reification }
ListTerm >> transitiveLookupIn: anEnv startAt: anIndex [
	
	| newTermSequence |
	newTermSequence := termsequence transitiveLookupIn: anEnv startAt: anIndex.
	^self class functor: functor termSequence: newTermSequence
]

{ #category : #unification }
ListTerm >> unifyWith: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"see comment in AbstractTerm"

	
	^aTerm
		unifyWithListTerm: self
		inEnv: anEnv
		myIndex: hisIndex
		hisIndex: myIndex
		inSource: inSource not
]

{ #category : #unification }
ListTerm >> unifyWithCompoundTerm: aCompound inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"unify a compound with a compound => if the arities are the  
	same and the functors unify, then recursively unify the subterms"

	
	| otherTermSequence |
	self multiplicity = aCompound multiplicity
		&
			(self functor
				unifyWith: aCompound functor
				inEnv: anEnv
				myIndex: myIndex
				hisIndex: hisIndex
				inSource: inSource)
		ifTrue:
			[otherTermSequence := aCompound termSequence.
			termsequence terms
				with: otherTermSequence terms
				do:
					[:myTerm :otherTerm | 
					(myTerm unifyWith: otherTerm inEnv: anEnv myIndex: myIndex hisIndex:
							hisIndex inSource: inSource) ifFalse: [^false]].
			^true]
		ifFalse: [^false]
]

{ #category : #unification }
ListTerm >> unifyWithListTerm: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	^self unifyWithCompoundTerm: aTerm inEnv: anEnv myIndex: myIndex hisIndex:
			hisIndex inSource: inSource
]

{ #category : #unification }
ListTerm >> unifyWithQuotedCodeTerm: aQCTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"a compound unifies with a quotedCode"

	
	^aQCTerm
		unifyWithListTerm: self
		inEnv: anEnv
		myIndex: hisIndex
		hisIndex: myIndex
		inSource: (inSource xor: true)
]

{ #category : #unification }
ListTerm >> unifyWithResultMessageTerm: aRM inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource [
	"ResultMessageTerm implements this"

	
	^aRM
		unifyWithListTerm: self
		inEnv: anEnv
		myIndex: targetIndex
		hisIndex: sourceIndex
		inSource: inSource not
]

{ #category : #unification }
ListTerm >> unifyWithSmalltalkTerm: stterm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"this is handled in SmalltalkTerm itself"

	
	^stterm
		unifyWithListTerm: self
		inEnv: anEnv
		myIndex: hisIndex
		hisIndex: myIndex
		inSource: (inSource xor: true)
]

{ #category : #unification }
ListTerm >> unifyWithUppedASTObject: anObject inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource [
	
	^anObject
		unifyWithListTerm: self
		inEnv: anEnv
		myIndex: targetIndex
		hisIndex: sourceIndex
		inSource: (inSource xor: true)
]

{ #category : #unification }
ListTerm >> unifyWithUppedObject: anObject inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource [
	
	^anObject
		unifyWithListTerm: self
		inEnv: anEnv
		myIndex: targetIndex
		hisIndex: sourceIndex
		inSource: (inSource xor: true)
]

{ #category : #unification }
ListTerm >> unifyWithVarArgsCompoundTerm: aVarArgsCompound inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"see comment in AbstractTerm"

	
	^aVarArgsCompound
		unifyWithListTerm: self
		inEnv: anEnv
		myIndex: hisIndex
		hisIndex: myIndex
		inSource: (inSource xor: true)
]

{ #category : #unification }
ListTerm >> unifyWithVariable: aVariable inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"we group all unfication with variables in the Variable class"

	
	| myAst |
	^(myAst := astlink soulDownIn: anEnv startAt: myIndex) class ==
			UppedASTObject
		ifTrue:
			[self halt.
			aVariable
				unifyWithUppedASTObject: myAst
				inEnv: anEnv
				myIndex: hisIndex
				hisIndex: myIndex
				inSource: inSource not]
		ifFalse:
			[aVariable
				unifyWithListTerm: self
				inEnv: anEnv
				myIndex: hisIndex
				hisIndex: myIndex
				inSource: inSource not]
]
