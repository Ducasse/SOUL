"
This class represents a variable that was decorated with additional types.

Instance Variables:
	decorators	<(LinkedWeakAssociationDictionary of: (AbstractTerm | Fact | Query | Rule)) | (SequenceableCollection of: (AbstractTerm | Fact | Query | Rule)) | TermSequence>	description of decorators


"
Class {
	#name : #DecoratedVariable,
	#superclass : #Variable,
	#instVars : [
		'decorators'
	],
	#category : 'SOUL-GrammarTerms'
}

{ #category : #decorators }
DecoratedVariable >> decorators: aCollection [
	
	decorators := aCollection
]

{ #category : #printing }
DecoratedVariable >> printForCompileOn: aStream [
	"see comment in AbstractTerm"

	
	aStream write: '('.
	super printForCompileOn: aStream.
	aStream write: ') decorators: (OrderedCollection new '.
	decorators
		do:
			[:each | 
			aStream write: 'add:('.
			each printForCompileOn: aStream.
			aStream write: ')']
		separatedBy: [aStream write: ';'].
	aStream write: ';yourself)'
]

{ #category : #printing }
DecoratedVariable >> printOn: aStream [
	"see comment in AbstractTerm"

	
	super printOn: aStream.
	aStream nextPutAll: '\'.
	decorators
		do: [:each | each printOn: aStream]
		separatedBy: [aStream nextPutAll: '\']
]

{ #category : #quotedCode }
DecoratedVariable >> quotedCodeToList [
	
	| previous |
	previous := self asNormalVariable.
	decorators
		reverseDo:
			[:each | 
			previous := SoulFactory current makeCompound
				functor: each
				termSequence:
					(SoulFactory current makeTermSequence terms: (OrderedCollection with: previous))].
	^previous
]
