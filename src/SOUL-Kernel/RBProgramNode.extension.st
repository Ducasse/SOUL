Extension { #name : #RBProgramNode }

{ #category : #'*SOUL-Kernel' }
RBProgramNode >> asRBNodeIn: anEnv startAt: anIndex [
	
	^self copy
]

{ #category : #'*SOUL-Kernel' }
RBProgramNode >> asSourceString [
	
	^self formattedCode
]

{ #category : #'*SOUL-Kernel' }
RBProgramNode >> functor [
	
	^ self class name soulUp
]

{ #category : #'*SOUL-Kernel' }
RBProgramNode >> listTermFrom: start to: stop [
	
	| coll |
	coll := OrderedCollection new.
	start
		to: stop
		do: [:i | coll add: (self reifiedSoulChildren at: i)].
	^SoulFactory current makeList new
		addChildrenInitial: (OrderedCollection with: (TermSequence terms: coll))
]

{ #category : #'*SOUL-Kernel' }
RBProgramNode >> multiplicity [
	
	^self reifiedSoulChildren size
]

{ #category : #'*SOUL-Kernel' }
RBProgramNode >> reifiedSoulChildren [
	
	(self hasProperty: #reifiedSoulChildren)
		ifFalse: [ self propertyAt: #reifiedSoulChildren put: (self soulChildren collect: #soulUp) ].
	
	^ self propertyAt: #reifiedSoulChildren ifAbsent:[ #() ]
]

{ #category : #'*SOUL-Kernel' }
RBProgramNode >> soulChildren [
	
	^self children
]

{ #category : #'*SOUL-Kernel' }
RBProgramNode >> soulUp [
	
	^UppedASTObject up: self
]

{ #category : #'*SOUL-Kernel' }
RBProgramNode >> unifyWithCompoundTerm: aCompound inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource [

	^ 
	 (self functor
		unifyWith: aCompound functor
		inEnv: anEnv
		myIndex: sourceIndex
		hisIndex: targetIndex
		inSource: inSource) & (self multiplicity = aCompound multiplicity)
		and:
			[aCompound termSequence terms
				doWithIndex:
					[:otherTerm :i | 
					(otherTerm isKindOf: UnderscoreVariable)
						ifFalse:
							[((self reifiedSoulChildren at: i) unifyWith: otherTerm inEnv: anEnv
								myIndex: sourceIndex hisIndex: targetIndex inSource: inSource)
								ifFalse: [^false]]].
			true]
]

{ #category : #'*SOUL-Kernel' }
RBProgramNode >> unifyWithVarArgsCompoundTerm: aCompound inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource [
	
	| varargsmultiplicity |
	varargsmultiplicity := aCompound realmultiplicity.
	^(self functor
		unifyWith: aCompound functor
		inEnv: anEnv
		myIndex: sourceIndex
		hisIndex: targetIndex
		inSource: inSource) & (self multiplicity >= varargsmultiplicity)
		and:
			[varargsmultiplicity = 1
				ifTrue:
					[(self
						listTermFrom: 1
						to: self multiplicity)
						unifyWith: (aCompound termSequence terms at: 1)
						inEnv: anEnv
						myIndex: sourceIndex
						hisIndex: targetIndex
						inSource: inSource]
				ifFalse:
					[1
						to: varargsmultiplicity - 1
						do:
							[:index | 
							((aCompound termSequence terms at: index)
								unifyWith: (self reifiedSoulChildren at: index)
								inEnv: anEnv
								myIndex: targetIndex
								hisIndex: sourceIndex
								inSource: inSource not) ifFalse: [^false]].
					(self
						listTermFrom: varargsmultiplicity
						to: self multiplicity)
						unifyWith: (aCompound termSequence terms at: varargsmultiplicity)
						inEnv: anEnv
						myIndex: sourceIndex
						hisIndex: targetIndex
						inSource: inSource]]
]
