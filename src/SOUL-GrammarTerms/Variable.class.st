"
Representation of a variable inside a logic parsetree.

Variables have a name and an address. The address is determined at 'parse time' and it is relative to the start of the activation record of the logic rule they are written in. 

"
Class {
	#name : #Variable,
	#superclass : #AbstractTerm,
	#instVars : [
		'address',
		'name'
	],
	#category : 'SOUL-GrammarTerms'
}

{ #category : #'instance creation' }
Variable class >> name: aName [
	
	^self new setName: aName
]

{ #category : #visitor }
Variable >> accept: aVisitor [
	"see comment in AbstractTerm"

	
	^aVisitor variableVisit: self
]

{ #category : #access }
Variable >> address [
	"a variable keeps its lexical address in the environment,  relative to a particular startindex of the activation record of the rule."

	
	^address
]

{ #category : #converting }
Variable >> asNormalVariable [
	
	^(Variable name: self name) setAddress: address
]

{ #category : #converting }
Variable >> asPredicateNameInEnv: anEnv startAt: anIndex [
	
	| val |
	"see comment in AbstractTerm"

	val := anEnv lookup: self startAt: anIndex.
	^val isNil
		ifTrue:
			[self error: 'Trying to resolve a term with an unbound variable as functor']
		ifFalse:
			[val term
				asPredicateNameInEnv: anEnv
				startAt: val envIndex]
]

{ #category : #converting }
Variable >> asSourceStringIn: anEnv startAt: anIndex [
	"see comment in AbstractTerm"

	"if I am bound, return the sourcestring of my bound value"

	
	| value |
	value := anEnv lookup: self startAt: anIndex.
	value isNil
		ifTrue: [^self asString]
		ifFalse:
			[^value term
				asSourceStringIn: anEnv
				startAt: value envIndex]
]

{ #category : #private }
Variable >> capitalizedName [
	
	^(name copy)
		at: 1
			put: name first asUppercase;
		yourself
]

{ #category : #testing }
Variable >> isIndexable [
	
	^false
]

{ #category : #slgtesting }
Variable >> isSLGEquivalentTo: aTerm [
	
	^aTerm isSLGEquivalentToVariable: self
]

{ #category : #slgtesting }
Variable >> isSLGEquivalentToVariable: aVariable [
	
	^true
]

{ #category : #testing }
Variable >> isVariable [
	
	^true
]

{ #category : #'list enumeration' }
Variable >> listDo: aBlock [
	
	
]

{ #category : #access }
Variable >> name [
	"a variable has a name"

	
	^name
]

{ #category : #printing }
Variable >> prettyPrintOn: aStream scope: id [
	"see comment in AbstractTerm"
	
	aStream withAttribute: (TextColor color:(Color r:0 g:0 b:256)) do: [
	aStream write: '?' , name].
	
]

{ #category : #printing }
Variable >> printAsPrologOn: aStream scope: anObject in: env startAt: idx [
	
	| value |
	"TODO: Should use a dummy environment instead of nil values"

	(env isNil or: [(value := env lookup: self startAt: idx) isNil])
		ifTrue: [aStream write: self capitalizedName]
		ifFalse:
			[value term
				printAsPrologOn: aStream
				scope: anObject
				in: env
				startAt: value envIndex]
]

{ #category : #printing }
Variable >> printForCompileOn: aStream [
	"see comment in AbstractTerm"

	
	aStream write: self class name , ' name: '''.
	aStream write: name.
	aStream write: ''''
]

{ #category : #printing }
Variable >> printOn: aStream [
	"see comment in AbstractTerm"

	"aStream write: '?' , name , ':' , address asString"

	
	aStream write: '?' , name
]

{ #category : #reification }
Variable >> protectedSoulDownIn: anEnv startAt: anIndex [
	"my downed value or an error"

	
	| value |
	value := anEnv lookup: self startAt: anIndex.
	value isNil
		ifTrue: [UnboundVariableException signal]
		ifFalse:
			[^value term
				soulDownIn: anEnv
				startAt: value envIndex]
]

{ #category : #resolving }
Variable >> resolveIn: anEnv startAt: anIndex [
	"resolve my value"

	
	| val |
	val := anEnv lookup: self startAt: anIndex.
	^val isNil
		ifTrue: [self error: 'Trying to resolve an unbound variable']
		ifFalse:
			[val term
				resolveIn: anEnv
				startAt: val envIndex]
]

{ #category : #access }
Variable >> setAddress: newAddress [
	"this method sets the address of the variable. Can only be used by the evaluator!"

	
	address := newAddress
]

{ #category : #initialize }
Variable >> setName: aName [
	
	name := aName
]

{ #category : #converting }
Variable >> smalltalkBlockDowningString [
	"see comment in AbstractTerm"

	
	^'(arg' , self name , ' protectedSoulDownIn: env startAt: envIndex)'
]

{ #category : #converting }
Variable >> smalltalkBlockString [
	"see comment in AbstractTerm"

	
	^'soulvar' , self name
]

{ #category : #reification }
Variable >> soulDownIn: anEnv startAt: anIndex [
	"myself or my downed value"

	
	| value |
	value := anEnv lookup: self startAt: anIndex.
	value isNil
		ifTrue: [^self]
		ifFalse:
			[^value term
				soulDownIn: anEnv
				startAt: value envIndex]
]

{ #category : #reification }
Variable >> transitiveLookupIn: anEnv startAt: anIndex [
	"myself or my downed value"

	
	| value |
	value := anEnv lookup: self startAt: anIndex.
	(value isNil or: [value term == self])
		ifTrue: [^self]
		ifFalse:
			[^value term
				transitiveLookupIn: anEnv
				startAt: value envIndex]
]

{ #category : #unification }
Variable >> unifyWith: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"see comment in AbstractTerm"

	
	^aTerm
		unifyWithVariable: self
		inEnv: anEnv
		myIndex: hisIndex
		hisIndex: myIndex
		inSource: (inSource xor: true)
]

{ #category : #unification }
Variable >> unifyWithAnnotatedTerm: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"I unify with a fuzzy term by binding to it or unifying my value with it"

	
	| val |
	val := anEnv lookup: self startAt: myIndex.
	val isNil
		ifTrue:
			[anEnv bind: self to: aTerm startAt: myIndex valueStartAt: hisIndex.
			^true]
		ifFalse:
			[^val term
				unifyWithAnnotatedTerm: aTerm
				inEnv: anEnv
				myIndex: val envIndex
				hisIndex: hisIndex
				inSource: inSource]
]

{ #category : #unification }
Variable >> unifyWithCompoundTerm: aCompound inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"I unify with a compound by binding to it or unifying my value with it"

	
	| val hisAst |
	(hisAst := aCompound astLink soulDownIn: anEnv startAt: hisIndex) class ==
			UppedASTObject
		ifTrue:
			[^self unifyWithUppedObject: hisAst inEnv: anEnv myIndex: myIndex hisIndex:
					hisIndex inSource: inSource]
		ifFalse:
			[val := anEnv lookup: self startAt: myIndex.
			val isNil
				ifTrue:
					[anEnv bind: self to: aCompound startAt: myIndex valueStartAt: hisIndex.
					^true]
				ifFalse:
					[^val term
						unifyWithCompoundTerm: aCompound
						inEnv: anEnv
						myIndex: val envIndex
						hisIndex: hisIndex
						inSource: inSource]]
]

{ #category : #unification }
Variable >> unifyWithCut: aCut inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource [
	"I unify with a cut by binding to it or by unifying it with my 
	value "

	
	| val |
	val := anEnv lookup: self startAt: sourceIndex.
	val isNil
		ifTrue:
			[anEnv bind: self to: aCut startAt: sourceIndex valueStartAt: targetIndex.
			^true]
		ifFalse:
			[^val term
				unifyWithCut: aCut
				inEnv: anEnv
				myIndex: val envIndex
				hisIndex: targetIndex
				inSource: inSource]
]

{ #category : #unification }
Variable >> unifyWithEmptyListConstant: anObject inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"I unify with an object by binding to it or by unifying it with my 
	value "

	
	| val |
	val := anEnv lookup: self startAt: myIndex.
	val isNil
		ifTrue:
			[anEnv bind: self to: anObject startAt: myIndex valueStartAt: hisIndex.
			^true]
		ifFalse:
			[^val term
				unifyWithEmptyListConstant: anObject
				inEnv: anEnv
				myIndex: val envIndex
				hisIndex: hisIndex
				inSource: inSource]
]

{ #category : #unification }
Variable >> unifyWithKeywordFunctor: anMPFunctor inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	| val |
	val := anEnv lookup: self startAt: myIndex.
	val isNil
		ifTrue:
			[anEnv bind: self to: anMPFunctor startAt: myIndex valueStartAt: hisIndex.
			^true]
		ifFalse:
			[^val term
				unifyWithKeywordFunctor: anMPFunctor
				inEnv: anEnv
				myIndex: val envIndex
				hisIndex: hisIndex
				inSource: inSource]
]

{ #category : #unification }
Variable >> unifyWithListTerm: aList inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"I unify with a compound by binding to it or unifying my value with it"

	
	| val |
	val := anEnv lookup: self startAt: myIndex.
	val isNil
		ifTrue:
			[anEnv bind: self to: aList startAt: myIndex valueStartAt: hisIndex.
			^true]
		ifFalse:
			[^val term
				unifyWithListTerm: aList
				inEnv: anEnv
				myIndex: val envIndex
				hisIndex: hisIndex
				inSource: inSource]
]

{ #category : #unification }
Variable >> unifyWithMessageFunctor: anMPFunctor inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	| val |
	val := anEnv lookup: self startAt: myIndex.
	val isNil
		ifTrue:
			[anEnv bind: self to: anMPFunctor startAt: myIndex valueStartAt: hisIndex.
			^true]
		ifFalse:
			[^val term
				unifyWithMessageFunctor: anMPFunctor
				inEnv: anEnv
				myIndex: val envIndex
				hisIndex: hisIndex
				inSource: inSource]
]

{ #category : #unification }
Variable >> unifyWithNativeClause: aNative inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource [
	
	^self unifyWithUppedObject: aNative inEnv: anEnv myIndex: sourceIndex
		hisIndex: targetIndex inSource: inSource
]

{ #category : #unification }
Variable >> unifyWithNegVariable: aVariable inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	| val val2 |
	val := anEnv lookup: self startAt: myIndex.
	val isNil
		ifTrue:
			[val2 := anEnv lookup: aVariable startAt: hisIndex.
			val2 isNil
				ifTrue:
					[aVariable ~~ self
						ifTrue:
							[inSource
								ifTrue:
									[anEnv
										bind: self
										to: aVariable asNormalVariable
										startAt: myIndex
										valueStartAt: hisIndex]
								ifFalse:
									[anEnv
										bind: aVariable asNormalVariable
										to: self
										startAt: hisIndex
										valueStartAt: myIndex]].
					^true]
				ifFalse:
					[^val2 term
						unifyWithVariable: self
						inEnv: anEnv
						myIndex: val2 envIndex
						hisIndex: myIndex
						inSource: (inSource xor: true)]]
		ifFalse:
			[^val term
				unifyWithNegVariable: aVariable
				inEnv: anEnv
				myIndex: val envIndex
				hisIndex: hisIndex
				inSource: inSource]
]

{ #category : #unification }
Variable >> unifyWithPosVariable: aVariable inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	| val |
	"transferred"

	val := anEnv lookup: self startAt: myIndex.
	val isNil
		ifTrue: [^false]
		ifFalse:
			[^val term
				unifyWithPosVariable: aVariable
				inEnv: anEnv
				myIndex: val envIndex
				hisIndex: hisIndex
				inSource: inSource]
]

{ #category : #unification }
Variable >> unifyWithQuotedCodeTerm: aQCTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	| val |
	val := anEnv lookup: self startAt: myIndex.
	val isNil
		ifTrue:
			[anEnv bind: self to: aQCTerm startAt: myIndex valueStartAt: hisIndex.
			^true]
		ifFalse:
			[^val term
				unifyWithQuotedCodeTerm: aQCTerm
				inEnv: anEnv
				myIndex: val envIndex
				hisIndex: hisIndex
				inSource: inSource]
]

{ #category : #unification }
Variable >> unifyWithResultMessageTerm: aResultMessage inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	| val |
	val := anEnv lookup: self startAt: myIndex.
	val isNil
		ifTrue:
			[anEnv bind: self to: aResultMessage startAt: myIndex valueStartAt:
					hisIndex.
			^true]
		ifFalse:
			[^val term
				unifyWithResultMessageTerm: aResultMessage
				inEnv: anEnv
				myIndex: val envIndex
				hisIndex: hisIndex
				inSource: inSource]
]

{ #category : #unification }
Variable >> unifyWithSmalltalkTerm: anSTTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	| val |
	val := anEnv lookup: self startAt: myIndex.
	val isNil
		ifTrue:
			[anEnv
				bind: self
				to: (anSTTerm evaluateIn: anEnv startAt: hisIndex) soulUp
				startAt: myIndex
				valueStartAt: hisIndex.
			^true]
		ifFalse:
			[^val term
				unifyWithSmalltalkTerm: anSTTerm
				inEnv: anEnv
				myIndex: val envIndex
				hisIndex: hisIndex
				inSource: inSource]
]

{ #category : #unification }
Variable >> unifyWithTemplateQueryTerm: aTQCTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	| val |
	val := anEnv lookup: self.
	val isNil
		ifTrue:
			[anEnv bind: self to: aTQCTerm startAt: myIndex valueStartAt: hisIndex.
			^true]
		ifFalse:
			[^val term
				unifyWithTemplateQueryTerm: aTQCTerm
				inEnv: anEnv
				myIndex: val envIndex
				hisIndex: hisIndex
				inSource: inSource]
]

{ #category : #unification }
Variable >> unifyWithUnaryMessageFunctor: unaryMessageFunctor inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	| val |
	val := anEnv lookup: self startAt: myIndex.
	val isNil
		ifTrue:
			[anEnv bind: self to: unaryMessageFunctor startAt: myIndex valueStartAt:
					hisIndex.
			^true]
		ifFalse:
			[^val term
				unifyWithUnaryMessageFunctor: unaryMessageFunctor
				inEnv: anEnv
				myIndex: val envIndex
				hisIndex: hisIndex
				inSource: inSource]
]

{ #category : #unification }
Variable >> unifyWithUppedASTObject: anObject inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"I unify with an object by binding to it or by unifying it with my 
	value "

	
	| val |
	val := anEnv lookup: self startAt: myIndex.
	val isNil
		ifTrue:
			[anEnv bind: self to: anObject startAt: myIndex valueStartAt: hisIndex.
			^true]
		ifFalse:
			[^val term
				unifyWithUppedASTObject: anObject
				inEnv: anEnv
				myIndex: val envIndex
				hisIndex: hisIndex
				inSource: inSource]
]

{ #category : #unification }
Variable >> unifyWithUppedObject: anObject inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"I unify with an object by binding to it or by unifying it with my 
	value "

	
	| val |
	val := anEnv lookup: self startAt: myIndex.
	val isNil
		ifTrue:
			[anEnv bind: self to: anObject startAt: myIndex valueStartAt: hisIndex.
			^true]
		ifFalse:
			[^val term
				unifyWithUppedObject: anObject
				inEnv: anEnv
				myIndex: val envIndex
				hisIndex: hisIndex
				inSource: inSource]
]

{ #category : #unification }
Variable >> unifyWithVarArgsCompoundTerm: aCompound inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"I unify with a compound by binding to it or unifying my value with it"

	
	| val |
	val := anEnv lookup: self startAt: myIndex.
	val isNil
		ifTrue:
			[anEnv bind: self to: aCompound startAt: myIndex valueStartAt: hisIndex.
			^true]
		ifFalse:
			[^val term
				unifyWithVarArgsCompoundTerm: aCompound
				inEnv: anEnv
				myIndex: val envIndex
				hisIndex: hisIndex
				inSource: inSource]
]

{ #category : #unification }
Variable >> unifyWithVariable: aVariable inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	| val val2 |
	val := anEnv lookup: self startAt: myIndex.
	val isNil
		ifTrue:
			[val2 := anEnv lookup: aVariable startAt: hisIndex.
			val2 isNil
				ifTrue:
					[(aVariable name = self name and: [myIndex = hisIndex])
						ifFalse:
							[inSource
								ifFalse:
									[anEnv bind: self to: aVariable startAt: myIndex valueStartAt: hisIndex]
								ifTrue:
									[anEnv bind: aVariable to: self startAt: hisIndex valueStartAt: myIndex]].
					^true]
				ifFalse:
					[^val2 term
						unifyWithVariable: self
						inEnv: anEnv
						myIndex: val2 envIndex
						hisIndex: myIndex
						inSource: (inSource xor: true)]]
		ifFalse:
			[^val term
				unifyWithVariable: aVariable
				inEnv: anEnv
				myIndex: val envIndex
				hisIndex: hisIndex
				inSource: inSource]
]
