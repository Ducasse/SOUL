"
This class represents logic formulas. That are logic terms having a functor (like a name) and a list of arguments.
"
Class {
	#name : #CompoundTerm,
	#superclass : #ResolvableTerm,
	#instVars : [
		'functor',
		'termsequence',
		'astlink'
	],
	#category : 'SOUL-GrammarTerms'
}

{ #category : #'instance creation' }
CompoundTerm class >> functor: aFunctor termSequence: aTermSequence [
	
	^self new setFunctor: aFunctor setTermSequence: aTermSequence
]

{ #category : #'instance creation' }
CompoundTerm class >> functor: aFunctor termSequence: aTermSequence astLink: aVariable [
	
	^self new initialize setFunctor: aFunctor setTermSequence: aTermSequence
		astLink: aVariable
]

{ #category : #visitor }
CompoundTerm >> accept: aVisitor [
	"see comment in AbstractTerm"

	
	^aVisitor compoundVisit: self
]

{ #category : #parsing }
CompoundTerm >> addTermFirst: term [
	
	termsequence addTermFirst: term
]

{ #category : #converting }
CompoundTerm >> asDCGConclusionWithSize: aSize [
	
	termsequence terms add: (SoulFactory current makeVariable name: 'tokens1').
	termsequence terms
		add: (SoulFactory current makeVariable name: 'tokens' , aSize asString).
	^self
]

{ #category : #converting }
CompoundTerm >> asDCGConditionFor: counter [
	
	(#(#not #and #or) includes: self functor name)
		ifTrue: [self error: 'Cannot use and/or/not in DCG production']
		ifFalse:
			[termsequence terms
				add: (SoulFactory current makeVariable name: 'tokens' , counter asString).
			termsequence terms
				add:
					(SoulFactory current makeVariable name: 'tokens' , (counter + 1) asString)]
]

{ #category : #converting }
CompoundTerm >> asFact [
	
	^SoulFactory current makeFact conclusion: self
]

{ #category : #converting }
CompoundTerm >> asQuery [
	
	^Query condition: (TermSequence terms: (OrderedCollection with: self))
]

{ #category : #printing }
CompoundTerm >> asSourceString [
	
	^self asSourceStringIn: nil startAt: nil
]

{ #category : #access }
CompoundTerm >> astLink [
	
	^astlink
]

{ #category : #access }
CompoundTerm >> astLink: anASTLink [
	
	astlink := anASTLink
]

{ #category : #resolving }
CompoundTerm >> clauseNotFoundIn: repository inEnv: env startAt: anIndex [
	
	| val |
	((self functor isKindOf: Variable)
		and:
			[(val := self functor soulDownIn: env startAt: anIndex) class ==
					BlockClosure])
		ifTrue: [^self resolveAsApplication: val inEnv: env startAt: anIndex].
	^super clauseNotFoundIn: repository inEnv: env startAt: anIndex
]

{ #category : #access }
CompoundTerm >> functor [
	"return our functor"

	
	^functor
]

{ #category : #access }
CompoundTerm >> functor: newFunctor [
	
	functor := newFunctor
]

{ #category : #testing }
CompoundTerm >> functorMatchesMultiplicity [
	
	^true
]

{ #category : #access }
CompoundTerm >> isASTLinkedIn: anEnv startAt: index [
	
	^((self astLink soulDownIn: anEnv startAt: index) isKindOf: Variable) not
]

{ #category : #testing }
CompoundTerm >> isCompoundTerm [
	
	^true
]

{ #category : #testing }
CompoundTerm >> isIndexable [
	
	^false
]

{ #category : #slgtesting }
CompoundTerm >> isSLGEquivalentTo: aTerm [
	
	^aTerm isSLGEquivalentToCompoundTerm: self
]

{ #category : #slgtesting }
CompoundTerm >> isSLGEquivalentToCompoundTerm: aCompoundTerm [
	
	^self termSequence isSLGEquivalentTo: aCompoundTerm termSequence
]

{ #category : #printing }
CompoundTerm >> listPrintOn: aStream [
	"this method is called if we are printed inside a list"

	
	aStream write: ','.
	self printOn: aStream
]

{ #category : #access }
CompoundTerm >> multiplicity [
	"return our multiplicity: the number of arguments of the compound"

	
	^self termSequence size
]

{ #category : #access }
CompoundTerm >> predicate [
	"See comment in AbstractTerm"

	
	^self functor isIndexable
		ifTrue: [self functor asPredicateNameInEnv: nil startAt: nil]
		ifFalse: [nil]
]

{ #category : #resolving }
CompoundTerm >> predicateInEnv: anEnv startAt: anIndex [
	
	^self functor asPredicateNameInEnv: anEnv startAt: anIndex
]

{ #category : #printing }
CompoundTerm >> prettyPrintOn: aStream scope: id [
	
	| newId |
	id = #asClause
		ifTrue: [newId := #asClause]
		ifFalse: [newId := #asTerm].
	functor prettyPrintAsFunctorOn: aStream scope: newId.
	aStream write: '('.
	termsequence
		do: [:aterm | aterm prettyPrintOn: aStream scope: #asTerm]
		separatedBy: [aStream write: ','].
	aStream write: ')'
]

{ #category : #printing }
CompoundTerm >> printAsPrologOn: aStream scope: id in: env startAt: idx [
	
	| newId |
	id = #asClause
		ifTrue: [newId := #asClause]
		ifFalse: [newId := #asTerm].
	functor printAsPrologFunctorOn: aStream scope: newId in: env startAt: idx.
	aStream write: '('.
	termsequence
		do:
			[:aterm | aterm printAsPrologOn: aStream scope: #asTerm in: env startAt: idx]
		separatedBy: [aStream write: ','].
	aStream write: ')'
]

{ #category : #printing }
CompoundTerm >> printForCompileOn: aStream [
	"see comment in AbstractTerm"

	
	aStream write: self class name , ' functor:('.
	functor printForCompileOn: aStream.
	aStream write: ') termSequence:('.
	termsequence printForCompileOn: aStream.
	aStream write: ')'
]

{ #category : #printing }
CompoundTerm >> printOn: aStream [
	"see comment in AbstractTerm"

	
	functor printAsFunctorOn: aStream.
	aStream write: '('.
	termsequence
		do: [:aterm | aterm printOn: aStream]
		separatedBy: [aStream write: ','].
	aStream write: ')'
]

{ #category : #scoping }
CompoundTerm >> recursiveDefinitionRepository: aRepository [
	"see comment in AbstractTerm"

	
	self definitionRepository: aRepository.
	termsequence recursiveDefinitionRepository: aRepository
]

{ #category : #resolving }
CompoundTerm >> resolveAsApplication: aBlockClosure inEnv: env startAt: anIndex [
	"I resolve a CompoundTerm whose functor is a BlockClosure as the application of the BlockClosure to the CompoundTerm's arguments."

	
	| numArgs downedTermArgs |
	downedTermArgs := self termSequence terms asArray
		collect: [:term | term soulDownIn: env startAt: anIndex].
	numArgs := aBlockClosure numArgs.
	numArgs = self multiplicity
		ifTrue:
			[^(aBlockClosure valueWithArguments: downedTermArgs) soulUp resolveIn: env
				startAt: anIndex].
	numArgs = (self multiplicity - 1)
		ifTrue:
			[^SoulFactory current makeNativeResolver
				onBlock:
					[:arg | 
					(downedTermArgs last
						unifyWith: arg soulUp
						inEnv: env
						myIndex: anIndex
						hisIndex: (env startUnify: 0)
						inSource: false)
						ifFalse:
							[env rollback.
							nil]
						ifTrue:
							[SoulFactory current makeResolutionResult
								condition: SoulFactory current makeTermSequence new
								rollbackInfo: env rollbackInfo
								conditionsEnvIndex: nil
								cutState: false]]
				withArguments:
					(OrderedCollection
						with:
							(aBlockClosure valueWithArguments: (downedTermArgs allButLast: 1)))].
	^SoulFactory current makeNativeResolver
		onBlock: [:res | res]
		withArguments: #(nil)
]

{ #category : #initialize }
CompoundTerm >> setFunctor: aFunctor setTermSequence: aTermSequence [
	"initialization of the compound"

	
	functor := aFunctor.
	termsequence := aTermSequence.
	astlink := HiddenVariable name: SoulFactory uniqueName
]

{ #category : #initialize }
CompoundTerm >> setFunctor: aFunctor setTermSequence: aTermSequence astLink: aVariable [
	"initialization of the compound"

	
	functor := aFunctor.
	termsequence := aTermSequence.
	astlink := aVariable
]

{ #category : #reification }
CompoundTerm >> soulDownIn: anEnv startAt: anIndex [
	"downing a compoundterm means downing the functor and downing the termsequence. HOWEVER: we must up the functor again because it gets included 	in the compound again"

	
	| newTermSequence value |
	value := astlink soulDownIn: anEnv startAt: anIndex.	"Need for a cleaner solution here... this requires me to work a bit on the environment too though"

	(value isKindOf: Variable)
		ifTrue:
			[newTermSequence := termsequence soulDownIn: anEnv startAt: anIndex.
			^(self class
				functor: (functor soulDownIn: anEnv startAt: anIndex) soulUp
				termSequence: newTermSequence
				astLink: value) definitionRepository: self definitionRepository]
		ifFalse: [^value]
]

{ #category : #reification }
CompoundTerm >> soulUp [
	"upping a compoundterm means returning myself because all my  
	subterms are automatically already upped"

	"| newSubTerms | 
	newSubTerms _ terms 
	collect: [:subTerm | subTerm qsoulUp]. 
	^ self class functor: functor qsoulUp terms: newSubTerms"

	
	^self
]

{ #category : #access }
CompoundTerm >> termSequence [
	"return the termsequence, containing our subterms"

	
	^termsequence
]

{ #category : #access }
CompoundTerm >> terms [
	"return the termsequence, containing our subterms"

	
	^termsequence terms
]

{ #category : #reification }
CompoundTerm >> transitiveLookupIn: anEnv startAt: anIndex [
	"See comment in AbstractTerm"

	
	| newTermSequence |
	newTermSequence := termsequence transitiveLookupIn: anEnv startAt: anIndex.
	^(self class
		functor: (functor transitiveLookupIn: anEnv startAt: anIndex)
		termSequence: newTermSequence
		astLink: (astlink transitiveLookupIn: anEnv startAt: anIndex))
		definitionRepository: self definitionRepository
]

{ #category : #unification }
CompoundTerm >> unifyWith: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"see comment in AbstractTerm"

	^aTerm
		unifyWithCompoundTerm: self
		inEnv: anEnv
		myIndex: hisIndex
		hisIndex: myIndex
		inSource: (inSource xor: true)
]

{ #category : #unification }
CompoundTerm >> unifyWithCompoundTerm: aCompound inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"unify a compound with a compound => if the arities are the  
	same and the functors unify, then recursively unify the subterms"

	
	| otherTermSequence myAst hisAst |
	(((myAst := astlink soulDownIn: anEnv startAt: myIndex) isKindOf: Variable)
		not
		and:
			[((hisAst := aCompound astLink soulDownIn: anEnv startAt: hisIndex)
				isKindOf: Variable) not])
		ifTrue:
			[^myAst unifyWith: hisAst inEnv: anEnv myIndex: myIndex hisIndex: hisIndex
				inSource: inSource]
		ifFalse:
			[self multiplicity = aCompound multiplicity
				&
					(self functor
						unifyWith: aCompound functor
						inEnv: anEnv
						myIndex: myIndex
						hisIndex: hisIndex
						inSource: inSource)
				ifTrue:
					[(astlink
						unifyWith: aCompound astLink
						inEnv: anEnv
						myIndex: myIndex
						hisIndex: hisIndex
						inSource: inSource) ifFalse: [^false].
					otherTermSequence := aCompound termSequence.
					termsequence terms
						with: otherTermSequence terms
						do:
							[:myTerm :otherTerm | 
							(myTerm unifyWith: otherTerm inEnv: anEnv myIndex: myIndex hisIndex:
									hisIndex inSource: inSource) ifFalse: [^false]].
					^true]
				ifFalse: [^false]]
]

{ #category : #unification }
CompoundTerm >> unifyWithListTerm: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	^false
]

{ #category : #unification }
CompoundTerm >> unifyWithQuotedCodeTerm: aQCTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"a compound unifies with a quotedCode"

	
	^aQCTerm
		unifyWithCompoundTerm: self
		inEnv: anEnv
		myIndex: hisIndex
		hisIndex: myIndex
		inSource: (inSource xor: true)
]

{ #category : #unification }
CompoundTerm >> unifyWithResultMessageTerm: aRM inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource [
	"ResultMessageTerm implements this"

	
	^aRM
		unifyWithCompoundTerm: self
		inEnv: anEnv
		myIndex: targetIndex
		hisIndex: sourceIndex
		inSource: inSource not
]

{ #category : #unification }
CompoundTerm >> unifyWithSmalltalkTerm: stterm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"this is handled in SmalltalkTerm itself"

	
	^stterm
		unifyWithCompoundTerm: self
		inEnv: anEnv
		myIndex: hisIndex
		hisIndex: myIndex
		inSource: (inSource xor: true)
]

{ #category : #unification }
CompoundTerm >> unifyWithUppedASTObject: anObject inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource [
	
	^anObject
		unifyWithCompoundTerm: self
		inEnv: anEnv
		myIndex: targetIndex
		hisIndex: sourceIndex
		inSource: (inSource xor: true)
]

{ #category : #unification }
CompoundTerm >> unifyWithUppedObject: anObject inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource [
	
	^anObject
		unifyWithCompoundTerm: self
		inEnv: anEnv
		myIndex: targetIndex
		hisIndex: sourceIndex
		inSource: (inSource xor: true)
]

{ #category : #unification }
CompoundTerm >> unifyWithVarArgsCompoundTerm: aVarArgsCompound inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"see comment in AbstractTerm"

	
	^aVarArgsCompound
		unifyWithCompoundTerm: self
		inEnv: anEnv
		myIndex: hisIndex
		hisIndex: myIndex
		inSource: (inSource xor: true)
]

{ #category : #unification }
CompoundTerm >> unifyWithVariable: aVariable inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"we group all unfication with variables in the Variable class"

	
	| myAst |
	^(myAst := astlink soulDownIn: anEnv startAt: myIndex) class ==
			UppedASTObject
		ifTrue:
			[
			aVariable
				unifyWithUppedASTObject: myAst
				inEnv: anEnv
				myIndex: hisIndex
				hisIndex: myIndex
				inSource: inSource not]
		ifFalse:
			[aVariable
				unifyWithCompoundTerm: self
				inEnv: anEnv
				myIndex: hisIndex
				hisIndex: myIndex
				inSource: inSource not]
]

{ #category : #access }
CompoundTerm >> usesPredicate: aPredicate multiplicity: aNumber [
	"This method is used by repositories to look up all predicated used inside a clause."

	
	(self functor isKindOf: Variable)
		ifFalse:
			[self predicate = aPredicate & (self multiplicity = aNumber)
				ifTrue: [^true]].
	^self termSequence usesPredicate: aPredicate multiplicity: aNumber
]
