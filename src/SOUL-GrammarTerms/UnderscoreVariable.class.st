"
This class represents the unnamed variable in logic parsetrees
"
Class {
	#name : #UnderscoreVariable,
	#superclass : #Variable,
	#category : 'SOUL-GrammarTerms'
}

{ #category : #visitor }
UnderscoreVariable >> accept: aVisitor [
	"see comment in QSOULAbstractTerm"

	
	^aVisitor underscoreVariableVisit: self
]

{ #category : #printing }
UnderscoreVariable >> listPrintOn: aStream [
	"Needed to display < ?avar  | ? > in SoulInteractive"

	
	aStream write: '|'.
	self printOn: aStream
]

{ #category : #printing }
UnderscoreVariable >> prettyListPrintOn: aStream scope: id [
	"Needed to display < ?avar  | ? > in SoulInteractive"

	
	aStream write: '|'.
	self printOn: aStream
]

{ #category : #printing }
UnderscoreVariable >> prettyPrintOn: aStream scope: id [
	"see comment in AbstractTerm"

	
	aStream withAttribute: (TextColor red) do: [self printOn: aStream]
]

{ #category : #printing }
UnderscoreVariable >> printAsPrologListOn: aStream scope: scope in: env startAt: idx [
	"Needed to display < ?avar  | ? > in SoulInteractive"

	
	aStream write: '|'.
	self printAsPrologOn: aStream scope: scope in: env startAt: idx
]

{ #category : #printing }
UnderscoreVariable >> printAsPrologOn: aStream scope: anObject in: env startAt: idx [
	
	aStream write: '_'
]

{ #category : #printing }
UnderscoreVariable >> printForCompileOn: aStream [
	"see comment in AbstractTerm"

	
	aStream write: self class name , ' new'
]

{ #category : #printing }
UnderscoreVariable >> printOn: aStream [
	"see comment in QSOULAbstractTerm"

	"Why not simply write: $? instead of Character value:63... well, if the  
	QSOULparsetreegenerator wanted to parse this (because I request the  
	parsetree of this method), it would generate a fact containing '?'  
	somewhere. Later on, the QSOUL interpreter would see a variable...  
	very confusing indeed"

	
	aStream write: (Character value: 63)
]

{ #category : #reification }
UnderscoreVariable >> soulDownIn: anEnv startAt: anIndex [
	
	^self
]

{ #category : #reification }
UnderscoreVariable >> transitiveLookupIn: anEnv startAt: anIndex [
	
	^self
]

{ #category : #unification }
UnderscoreVariable >> unifyWith: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"I unify with everything"

	
	^aTerm unifyWithUnderscoreVariable: self inEnv: anEnv myIndex: myIndex
		hisIndex: hisIndex inSource: inSource
]

{ #category : #unification }
UnderscoreVariable >> unifyWithCompoundTerm: aCompound inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"I unify with everything"

	
	^true
]

{ #category : #unification }
UnderscoreVariable >> unifyWithEmptyListConstant: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	^true
]

{ #category : #unification }
UnderscoreVariable >> unifyWithListTerm: aList inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	^true
]

{ #category : #unification }
UnderscoreVariable >> unifyWithNegVariable: aVariable inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"I unify with negative variables"

	
	^true
]

{ #category : #unification }
UnderscoreVariable >> unifyWithPosVariable: aVariable inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"I do not unify with a positive variable"

	
	^false
]

{ #category : #unification }
UnderscoreVariable >> unifyWithQuotedCodeTerm: aQCTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"I unify with everything"

	
	^true
]

{ #category : #unification }
UnderscoreVariable >> unifyWithSmalltalkTerm: anSTTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"I unify with everything"

	
	^true
]

{ #category : #unification }
UnderscoreVariable >> unifyWithUppedASTObject: anObject inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"I unify with everything"

	
	^true
]

{ #category : #unification }
UnderscoreVariable >> unifyWithUppedObject: anObject inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"I unify with everything"

	
	^true
]

{ #category : #unification }
UnderscoreVariable >> unifyWithVariable: aVariable inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"I unify with everything"

	
	^true
]
