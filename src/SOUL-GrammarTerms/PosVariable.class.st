Class {
	#name : #PosVariable,
	#superclass : #Variable,
	#category : 'SOUL-GrammarTerms'
}

{ #category : #printing }
PosVariable >> prettyPrintOn: aStream scope: id [
	"see comment in AbstractTerm"
	aStream withAttribute: (TextColor red) do: [aStream write: '+?' , name]
	
]

{ #category : #printing }
PosVariable >> printOn: aStream [
	"see comment in AbstractTerm"

	"aStream write: '&' , name , ':' , address asString"

	
	aStream write: '+?' , name
]

{ #category : #unification }
PosVariable >> unifyWith: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"see comment in AbstractTerm"

	
	^aTerm
		unifyWithPosVariable: self
		inEnv: anEnv
		myIndex: hisIndex
		hisIndex: myIndex
		inSource: (inSource xor: true)
]

{ #category : #unification }
PosVariable >> unifyWithUnderscoreVariable: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	^false
]

{ #category : #unification }
PosVariable >> unifyWithVariable: aVariable inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	| val val2 |
	val := anEnv lookup: self startAt: myIndex.
	val isNil
		ifTrue:
			[val2 := anEnv lookup: aVariable startAt: hisIndex.
			val2 isNil
				ifTrue: [^false]
				ifFalse:
					[^val2 term
						unifyWithPosVariable: self
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
