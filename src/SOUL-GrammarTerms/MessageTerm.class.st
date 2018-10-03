Class {
	#name : #MessageTerm,
	#superclass : #CompoundTerm,
	#category : 'SOUL-GrammarTerms'
}

{ #category : #parsing }
MessageTerm >> addKeyword: keyword term: term [
	
	functor addKeyword: keyword.
	termsequence addTermFirst: term
]

{ #category : #access }
MessageTerm >> arguments [
	
	^termsequence terms allButFirst: 1
]

{ #category : #testing }
MessageTerm >> functorMatchesMultiplicity [
	
	^functor multiplicity = self multiplicity
]

{ #category : #testing }
MessageTerm >> isKeyworded [
	
	^functor isKindOf: KeywordFunctor
]

{ #category : #testing }
MessageTerm >> isKeywordedMessage [
	
	^functor isKindOf: MessageFunctor
]

{ #category : #testing }
MessageTerm >> isMessage [
	
	^self isKeywordedMessage or: [self isUnaryMessage]
]

{ #category : #testing }
MessageTerm >> isMultiPart [
	
	^self isKeywordedMessage or: [self isKeyworded]
]

{ #category : #testing }
MessageTerm >> isUnaryMessage [
	
	^functor isKindOf: UnaryMessageFunctor
]

{ #category : #printing }
MessageTerm >> prettyPrintAsKeywordArgOn: aStream scope: id [
	"UGLY: should change type test to double dispatching"

	
	self isMultiPart ifTrue: [aStream write: '('].
	self prettyPrintOn: aStream scope: id.
	self isMultiPart ifTrue: [aStream write: ')']
]

{ #category : #printing }
MessageTerm >> prettyPrintKeywordMessageStyleOn: aStream scope: id [
	
	| newId |
	id = #asClause
		ifTrue: [newId := #asClause]
		ifFalse: [newId := #asTerm].
	self receiver prettyPrintAsKeywordArgOn: aStream scope: newId.
	aStream write: ' '.
	self functor keywords
		with: (termsequence terms allButFirst: 1)
		do:
			[:keyword :aterm | 
			keyword prettyPrintAsKeywordOn: aStream scope: newId.
			aStream write: ': '.
			aterm prettyPrintAsKeywordArgOn: aStream scope: #asTerm]
		separatedBy: [aStream write: ' ']
]

{ #category : #printing }
MessageTerm >> prettyPrintKeywordStyleOn: aStream scope: id [
	
	| newId |
	id = #asClause
		ifTrue: [newId := #asClause]
		ifFalse: [newId := #asTerm].
	self functor keywords
		with: termsequence terms
		do:
			[:keyword :aterm | 
			keyword prettyPrintAsKeywordOn: aStream scope: newId.
			aStream write: ': '.
			aterm prettyPrintAsKeywordArgOn: aStream scope: newId]
		separatedBy: [aStream write: ' ']
]

{ #category : #printing }
MessageTerm >> prettyPrintOn: aStream scope: id [
	"UGLY: should really be replaced with nice double dispatching"

	
	self isKeyworded
		ifTrue: [^self prettyPrintKeywordStyleOn: aStream scope: id].
	self isKeywordedMessage
		ifTrue: [^self prettyPrintKeywordMessageStyleOn: aStream scope: id].
	self isUnaryMessage
		ifTrue: [^self prettyPrintUnaryMessageStyleOn: aStream scope: id].
	self halt: 'terribly wrong'
]

{ #category : #printing }
MessageTerm >> prettyPrintUnaryMessageStyleOn: aStream scope: id [
	
	termsequence terms first prettyPrintOn: aStream scope: #asTerm.
	aStream write: ' '.
	aStream withAttributes:
			(Array
				with: TextColor black
				with: TextEmphasis bold) do:[
	functor message prettyPrintOn: aStream scope: #asTerm.]
]

{ #category : #printing }
MessageTerm >> printAsKeywordArgOn: aStream [
	"UGLY: should change type test to double dispatching"

	
	self isMultiPart ifTrue: [aStream write: '('].
	self printOn: aStream.
	self isMultiPart ifTrue: [aStream write: ')']
]

{ #category : #printing }
MessageTerm >> printKeywordMessageStyleOn: aStream [
	"see comment in AbstractTerm"

	
	self receiver printAsKeywordArgOn: aStream.
	aStream write: ' '.
	self functor keywords
		with: (termsequence terms allButFirst: 1)
		do:
			[:keyword :aterm | 
			keyword printOn: aStream.
			aStream write: ': '.
			aterm printAsKeywordArgOn: aStream]
		separatedBy: [aStream write: ' ']
]

{ #category : #printing }
MessageTerm >> printKeywordStyleOn: aStream [
	"see comment in AbstractTerm"

	
	self functor keywords
		with: termsequence terms
		do:
			[:keyword :aterm | 
			keyword printOn: aStream.
			aStream write: ': '.
			aterm printAsKeywordArgOn: aStream]
		separatedBy: [aStream write: ' ']
]

{ #category : #printing }
MessageTerm >> printOn: aStream [
	"UGLY: should really be replaced with nice double dispatching"

	"No... really?"

	
	self isKeyworded ifTrue: [^self printKeywordStyleOn: aStream].
	self isKeywordedMessage
		ifTrue: [^self printKeywordMessageStyleOn: aStream].
	self isUnaryMessage ifTrue: [^self printUnaryMessageStyleOn: aStream].
	self halt: 'terribly wrong'
]

{ #category : #printing }
MessageTerm >> printUnaryMessageStyleOn: aStream [
	
	termsequence terms first printOn: aStream.
	aStream write: ' '.
	functor message printOn: aStream
]

{ #category : #access }
MessageTerm >> receiver [
	"Only makes sense when the functor of this compound is a message-like functor"

	
	^termsequence terms at: 1
]

{ #category : #access }
MessageTerm >> selector [
	
	^functor name
]
