"
Represents the Prolog cut.


"
Class {
	#name : #Cut,
	#superclass : #ResolvableTerm,
	#category : 'SOUL-GrammarTerms'
}

{ #category : #visitor }
Cut >> accept: aVisitor [
	"See comment in AbstractTerm"

	
	^aVisitor cutVisit: self
]

{ #category : #testing }
Cut >> isCut [
	
	^true
]

{ #category : #printing }
Cut >> printAsPrologOn: aStream scope: scope in: env startAt: idx [
	"See comment in AbstractTerm"

	
	aStream write: '!'
]

{ #category : #printing }
Cut >> printForCompileOn: aStream [
	"See comment in AbstractTerm"

	
	aStream write: self class name , ' new'
]

{ #category : #printing }
Cut >> printOn: aStream [
	"See comment in AbstractTerm"

	
	aStream write: '!'
]

{ #category : #resolving }
Cut >> resolveIn: anEnv startAt: anIndex [
	"Resolving a cut means cutting of the callstack to avoid backtracking and making an empty resolver to allow further evaluation"

	
	anEnv callStack cut.
	^NativeResolver
		onBlock:
			[:foo | 
			ResolutionResult
				condition:
					(SoulFactory current makeTermSequence
						terms: OrderedCollection new
						containsCut: false)
				rollbackInfo: anEnv rollbackInfo
				conditionsEnvIndex: anEnv currentVariableIndex
				cutState: false]
		withArguments:
			((OrderedCollection new)
				add: #foo;
				yourself)
]

{ #category : #reification }
Cut >> transitiveLookupIn: anEnv startAt: anIndex [
	
	^self
]

{ #category : #unification }
Cut >> unifyWith: aTerm inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource [
	"double dispatch the unification of the term"

	
	^aTerm
		unifyWithCut: self
		inEnv: anEnv
		myIndex: targetIndex
		hisIndex: sourceIndex
		inSource: (inSource xor: true)
]

{ #category : #unification }
Cut >> unifyWithCut: aCut inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource [
	
	^true
]

{ #category : #unification }
Cut >> unifyWithVariable: aVariable inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"we group all unfication with variables in the Variable class"

	
	^aVariable
		unifyWithCut: self
		inEnv: anEnv
		myIndex: hisIndex
		hisIndex: myIndex
		inSource: (inSource xor: true)
]
