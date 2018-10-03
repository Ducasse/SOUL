"
Represents a special kind of variables. Delayed variables have the special meaning that any Smalltalk Term unified with them will not be evaluated but merely bound to them. Normal variables evaluate the Smalltalk Term and bind to the resulting value.


"
Class {
	#name : #DelayedVariable,
	#superclass : #Variable,
	#category : 'SOUL-GrammarTerms'
}

{ #category : #visitor }
DelayedVariable >> accept: aVisitor [
	"see comment in AbstractTerm"

	
	^aVisitor delayedVariableVisit: self
]

{ #category : #converting }
DelayedVariable >> asSmalltalkString [
	"see comment in AbstractTerm"

	
	^'(env transitiveLookup: soulvar' , self name , ')'
]

{ #category : #printing }
DelayedVariable >> listPrintOn: aStream [
	"this method is called if we are printed inside a list"

	
	aStream write: '|'.
	self printOn: aStream
]

{ #category : #printing }
DelayedVariable >> prettyPrintOn: aStream scope: id [
	"see comment in AbstractTerm"

	
	aStream withAttribute:(TextColor red) do:[
	aStream write: '&' , name].
	
]

{ #category : #printing }
DelayedVariable >> printForCompileOn: aStream [
	"see comment in AbstractTerm"

	
	aStream write: self class name , ' name: '''.
	aStream write: name.
	aStream write: ''''
]

{ #category : #printing }
DelayedVariable >> printOn: aStream [
	"see comment in AbstractTerm"

	"aStream write: '&' , name , ':' , address asString"

	
	aStream write: '&' , name
]

{ #category : #converting }
DelayedVariable >> smalltalkBlockDowningString [
	"see comment in Variable"

	
	^'(env transitiveLookup: arg' , self name , ' startAt: envIndex)'
]

{ #category : #reification }
DelayedVariable >> soulDownIn: anEnv startAt: anIndex [
	
	| value |
	value := anEnv lookup: self startAt: anIndex.
	value isNil
		ifTrue: [^self]
		ifFalse:
			[^value term
				transitiveLookupIn: anEnv
				startAt: value envIndex]
]

{ #category : #unification }
DelayedVariable >> unifyWith: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: aBool [
	
	^aTerm
		unifyWithDelayedVariable: self
		inEnv: anEnv
		myIndex: hisIndex
		hisIndex: myIndex
		inSource: aBool not
]

{ #category : #unification }
DelayedVariable >> unifyWithSmalltalkTerm: anSTTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"see comment in AbstractTerm"

	
	| val |
	val := anEnv lookup: self startAt: myIndex.
	val isNil
		ifTrue:
			[anEnv bind: self to: anSTTerm startAt: myIndex valueStartAt: hisIndex.
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
DelayedVariable >> unifyWithVariable: aVariable inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"see comment in AbstractTerm"

	
	| val val2 |
	val := anEnv lookup: self startAt: myIndex.
	val isNil
		ifTrue:
			[val2 := anEnv lookup: aVariable startAt: hisIndex.
			val2 isNil
				ifTrue:
					[inSource
						ifTrue:
							[anEnv bind: self to: aVariable startAt: myIndex valueStartAt: hisIndex]
						ifFalse:
							[anEnv bind: aVariable to: self startAt: hisIndex valueStartAt: myIndex].
					^true]
				ifFalse:
					[^val2 term
						unifyWithDelayedVariable: self
						inEnv: anEnv
						myIndex: val2 envIndex
						hisIndex: myIndex
						inSource: (inSource xor: true)]]
		ifFalse:
			[^val term
				unifyWithDelayedVariable: aVariable
				inEnv: anEnv
				myIndex: val envIndex
				hisIndex: hisIndex
				inSource: inSource]
]
