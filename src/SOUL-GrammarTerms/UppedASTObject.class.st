Class {
	#name : #UppedASTObject,
	#superclass : #UppedObject,
	#category : 'SOUL-GrammarTerms'
}

{ #category : #unification }
UppedASTObject >> unifyWith: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"see comment in AbstractTerm"

	
	^aTerm
		unifyWithUppedASTObject: self
		inEnv: anEnv
		myIndex: hisIndex
		hisIndex: myIndex
		inSource: (inSource xor: true)
]

{ #category : #unification }
UppedASTObject >> unifyWithCompoundTerm: aCompound inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource [
	
	(aCompound isASTLinkedIn: anEnv startAt: targetIndex)
		ifTrue:
			[^self
				unifyWith: aCompound astLink
				inEnv: anEnv
				myIndex: sourceIndex
				hisIndex: targetIndex
				inSource: inSource]
		ifFalse:
			[^(self
				unifyWith: aCompound astLink
				inEnv: anEnv
				myIndex: sourceIndex
				hisIndex: targetIndex
				inSource: inSource)
				and:
					[smalltalkValue unifyWithCompoundTerm: aCompound inEnv: anEnv myIndex:
							sourceIndex hisIndex: targetIndex inSource: inSource]]
]

{ #category : #unification }
UppedASTObject >> unifyWithListTerm: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	^false
]

{ #category : #unification }
UppedASTObject >> unifyWithPosVariable: aVariable inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"we group all unfication with variables in the Variable class"

	
	^aVariable
		unifyWithUppedASTObject: self
		inEnv: anEnv
		myIndex: hisIndex
		hisIndex: myIndex
		inSource: (inSource xor: true)
]

{ #category : #unification }
UppedASTObject >> unifyWithQuotedCodeTerm: aQCTerm inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource [
	
	^smalltalkValue source
		matchesRegex: (aQCTerm asSourceStringIn: anEnv startAt: targetIndex)
]

{ #category : #unification }
UppedASTObject >> unifyWithUppedASTObject: anObject inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource [
	
	^smalltalkValue
		unifyWith: anObject smalltalkValue
		inEnv: anEnv
		myIndex: sourceIndex
		hisIndex: targetIndex
		inSource: inSource
]

{ #category : #unification }
UppedASTObject >> unifyWithVarArgsCompoundTerm: aCompound inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource [
	
	(aCompound isASTLinkedIn: anEnv startAt: targetIndex)
		ifTrue:
			[^self
				unifyWith: aCompound astLink
				inEnv: anEnv
				myIndex: sourceIndex
				hisIndex: targetIndex
				inSource: inSource]
		ifFalse:
			[^(self
				unifyWith: aCompound astLink
				inEnv: anEnv
				myIndex: sourceIndex
				hisIndex: targetIndex
				inSource: inSource)
				and:
					[smalltalkValue unifyWithVarArgsCompoundTerm: aCompound inEnv: anEnv
						myIndex: sourceIndex hisIndex: targetIndex inSource: inSource]]
]

{ #category : #unification }
UppedASTObject >> unifyWithVariable: aVariable inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"we group all unfication with variables in the Variable class"

	
	^aVariable
		unifyWithUppedASTObject: self
		inEnv: anEnv
		myIndex: hisIndex
		hisIndex: myIndex
		inSource: (inSource xor: true)
]
