Class {
	#name : #NegVariable,
	#superclass : #Variable,
	#category : 'SOUL-GrammarTerms'
}

{ #category : #printing }
NegVariable >> prettyPrintOn: aStream scope: id [
	"see comment in AbstractTerm"
	aStream withAttribute: (TextColor red) do: [aStream write: '-?' , name]
	
]

{ #category : #printing }
NegVariable >> printOn: aStream [
	"see comment in AbstractTerm"

	"aStream write: '&' , name , ':' , address asString"

	
	aStream write: '-?' , name
]

{ #category : #unification }
NegVariable >> unifyWith: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"see comment in AbstractTerm"

	
	^aTerm
		unifyWithNegVariable: self
		inEnv: anEnv
		myIndex: hisIndex
		hisIndex: myIndex
		inSource: (inSource xor: true)
]

{ #category : #unification }
NegVariable >> unifyWithCompoundTerm: aCompound inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	^false
]

{ #category : #unification }
NegVariable >> unifyWithQuotedCodeTerm: aQCTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	^false
]

{ #category : #unification }
NegVariable >> unifyWithResultMessageTerm: aResultMessage inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	^false
]

{ #category : #unification }
NegVariable >> unifyWithSmalltalkTerm: anSTTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	^false
]

{ #category : #unification }
NegVariable >> unifyWithTemplateQueryTerm: aTQCTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	^false
]

{ #category : #unification }
NegVariable >> unifyWithUppedObject: anObject inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	^false
]

{ #category : #unification }
NegVariable >> unifyWithVariable: aVariable inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
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
										bind: self asNormalVariable
										to: aVariable
										startAt: myIndex
										valueStartAt: hisIndex]
								ifFalse:
									[anEnv
										bind: aVariable
										to: self asNormalVariable
										startAt: hisIndex
										valueStartAt: myIndex]].
					^true]
				ifFalse:
					[^val2 term
						unifyWithNegVariable: self
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
