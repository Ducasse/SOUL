"
This class represents a compoundterm that has a variable-length argument list. 
"
Class {
	#name : #VarArgsCompoundTerm,
	#superclass : #CompoundTerm,
	#category : 'SOUL-GrammarTerms'
}

{ #category : #access }
VarArgsCompoundTerm >> multiplicity [
	
	^-1
]

{ #category : #printing }
VarArgsCompoundTerm >> prettyPrintOn: aStream scope: id [
	
	| newId |
	id = #asClause
		ifTrue: [newId := #asClause]
		ifFalse: [newId := #asTerm].
	functor prettyPrintAsFunctorOn: aStream scope: newId.
	aStream write: '@('.
	termsequence
		do: [:aterm | aterm prettyPrintOn: aStream scope: #asTerm]
		separatedBy: [aStream write: ','].
	aStream write: ')'
]

{ #category : #printing }
VarArgsCompoundTerm >> printOn: aStream [
	"see comment in AbstractTerm"

	
	functor printAsFunctorOn: aStream.
	aStream write: '@('.
	termsequence
		do: [:aterm | aterm printOn: aStream]
		separatedBy: [aStream write: ','].
	aStream write: ')'
]

{ #category : #private }
VarArgsCompoundTerm >> realmultiplicity [
	
	^self termSequence size
]

{ #category : #resolving }
VarArgsCompoundTerm >> resolveIn: env startAt: anIndex [
	"resolve as a normal clause: do lookup in repository and create a resolver  on it"

	
	| foundClauses |
	foundClauses := self definitionRepository
		varArgsAddressLookup:
			(self
				lexicalAddressInEnv: env
				startAt: anIndex
				ifAbsent:
					[^self
						clauseNotFoundIn: self definitionRepository
						inEnv: env
						startAt: anIndex]).
	^SoulFactory current makeResolver fromClause: self toClauses: foundClauses
		inEnv: env startAt: anIndex
]

{ #category : #unification }
VarArgsCompoundTerm >> unifyWith: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"see comment in AbstractTerm"

	
	^aTerm
		unifyWithVarArgsCompoundTerm: self
		inEnv: anEnv
		myIndex: hisIndex
		hisIndex: myIndex
		inSource: (inSource xor: true)
]

{ #category : #unification }
VarArgsCompoundTerm >> unifyWithCompoundTerm: aCompound inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"unify a compound with a VarArgscompound => if the functors unify and our multiplicity is smaller or equal to the normal compound's multiplicity, then we unify the subterms and our last subterm unifies with a list of the remaining subterms of the normal compound"

	
	| otherTermSequence newListTerm |
	(self functor
		unifyWith: aCompound functor
		inEnv: anEnv
		myIndex: myIndex
		hisIndex: hisIndex
		inSource: inSource) & (aCompound multiplicity >= self realmultiplicity)
		ifTrue:
			[otherTermSequence := aCompound termSequence.
			self realmultiplicity = 1
				ifTrue:
					[newListTerm := SoulFactory current makeList
						termSequence: aCompound termSequence.
					(newListTerm
						unifyWith: (termsequence terms at: 1)
						inEnv: anEnv
						myIndex: hisIndex
						hisIndex: myIndex
						inSource: (inSource xor: true)) ifFalse: [^false]]
				ifFalse:
					[1
						to: self realmultiplicity - 1
						do:
							[:index | 
							((otherTermSequence terms at: index)
								unifyWith: (termsequence terms at: index)
								inEnv: anEnv
								myIndex: hisIndex
								hisIndex: myIndex
								inSource: (inSource xor: true)) ifFalse: [^false]].
					(SoulFactory current makeList
						termSequence:
							(TermSequence
								terms:
									(aCompound termSequence terms
										copyFrom: self realmultiplicity
										to: aCompound multiplicity)))
						unifyWith: (termsequence terms at: self realmultiplicity)
						inEnv: anEnv
						myIndex: hisIndex
						hisIndex: myIndex
						inSource: (inSource xor: true)].
			^true]
		ifFalse: [^false]
]

{ #category : #unification }
VarArgsCompoundTerm >> unifyWithListTerm: aListTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	| otherTermSequence newListTerm collection |
	collection := aListTerm collectIn: anEnv startAt: hisIndex.
	(self functor
		unifyWith: aListTerm functor
		inEnv: anEnv
		myIndex: myIndex
		hisIndex: hisIndex
		inSource: inSource) & (collection size >= self realmultiplicity)
		ifTrue:
			[otherTermSequence := TermSequence
				terms: (collection collect: [:t | t soulUp]).
			self realmultiplicity = 1
				ifTrue:
					[newListTerm := SoulFactory current makeList termSequence: otherTermSequence.
					newListTerm
						unifyWith: (termsequence terms at: 1)
						inEnv: anEnv
						myIndex: hisIndex
						hisIndex: myIndex
						inSource: (inSource xor: true)]
				ifFalse:
					[1
						to: self realmultiplicity - 1
						do:
							[:index | 
							((otherTermSequence terms at: index)
								unifyWith: (termsequence terms at: index)
								inEnv: anEnv
								myIndex: hisIndex
								hisIndex: myIndex
								inSource: (inSource xor: true)) ifFalse: [^false]].
					(SoulFactory current makeList
						termSequence:
							(TermSequence
								terms:
									(collection
										copyFrom: self realmultiplicity
										to: collection size)))
						unifyWith: (termsequence terms at: self realmultiplicity)
						inEnv: anEnv
						myIndex: hisIndex
						hisIndex: myIndex
						inSource: (inSource xor: true)].
			^true]
		ifFalse: [^false]
]

{ #category : #unification }
VarArgsCompoundTerm >> unifyWithUppedASTObject: anObject inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource [
	
	^anObject
		unifyWithVarArgsCompoundTerm: self
		inEnv: anEnv
		myIndex: targetIndex
		hisIndex: sourceIndex
		inSource: (inSource xor: true)
]

{ #category : #unification }
VarArgsCompoundTerm >> unifyWithUppedObject: anObject inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource [
	
	^anObject
		unifyWithVarArgsCompoundTerm: self
		inEnv: anEnv
		myIndex: targetIndex
		hisIndex: sourceIndex
		inSource: (inSource xor: true)
]

{ #category : #unification }
VarArgsCompoundTerm >> unifyWithVarArgsCompoundTerm: aCompound inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	^super unifyWithCompoundTerm: aCompound inEnv: anEnv myIndex: myIndex
		hisIndex: hisIndex inSource: inSource
]

{ #category : #unification }
VarArgsCompoundTerm >> unifyWithVariable: aVariable inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"we group all unfication with variables in the Variable class"

	
	^aVariable
		unifyWithVarArgsCompoundTerm: self
		inEnv: anEnv
		myIndex: hisIndex
		hisIndex: myIndex
		inSource: (inSource xor: true)
]
