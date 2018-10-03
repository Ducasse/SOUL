"
Represents SOUL QuotedCode on the Smalltalk level. It's a subclass of text containing information an behaviour to reproduce an upped version of the quotedcode in SOUL

"
Class {
	#name : #DownedQuotedCode,
	#superclass : #Text,
	#instVars : [
		'content',
		'block',
		'variables'
	],
	#category : 'SOUL-GrammarTerms'
}

{ #category : #'instance creation' }
DownedQuotedCode class >> fromString: aString [
	
	| qc |
	qc := QuotedCodeTerm source: aString.
	^self
		fromString: aString
		variables: qc variablesIncludingNils
		content: qc content
		block: qc block
]

{ #category : #'instance creation' }
DownedQuotedCode class >> fromString: aString variables: variables content: terms block: aBlock [
	
	| instance |
	instance := super fromString: aString.
	instance variables: variables content: terms block: aBlock.
	^instance
]

{ #category : #converting }
DownedQuotedCode >> asList [
	
	^SoulFactory current makeList
		termSequence:
			(TermSequence new terms: (content collect: [:each | each quotedCodeToList]))
]

{ #category : #printing }
DownedQuotedCode >> printOn: aStream [
	"Print the string of the downed quotedcode"

	
	aStream print: string
]

{ #category : #reification }
DownedQuotedCode >> soulUp [
	"produce an upped quotedcode of this downed quotedcode"

	
	^QuotedCodeTerm
		source: self asString
		variables: variables
		content: content
		block: block
]

{ #category : #initialize }
DownedQuotedCode >> variables: vars content: terms block: aBlock [
	
	variables := vars.
	content := terms.
	block := aBlock
]
