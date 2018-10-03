Class {
	#name : #DownedTemplateQuery,
	#superclass : #DownedQuotedCode,
	#instVars : [
		'type',
		'queries',
		'trees'
	],
	#category : 'SOUL-GrammarTerms'
}

{ #category : #'instance creation' }
DownedTemplateQuery class >> fromString: aString variables: aCollectionOfVars content: aContent block: aBlock parsetrees: aParsetree queries: aQueries type: aType [
	
	| inst |
	inst := super fromString: aString variables: aCollectionOfVars content:
			aContent block: aBlock.
	inst parsetree: aParsetree queries: aQueries type: aType.
	^inst
]

{ #category : #accessing }
DownedTemplateQuery >> parsetree [
	
	^trees
]

{ #category : #initialize }
DownedTemplateQuery >> parsetree: aParsetree queries: aQueries type: aType [
	
	trees := aParsetree.
	queries := aQueries.
	type := aType
]

{ #category : #reification }
DownedTemplateQuery >> soulUp [
	"produce an upped quotedcode of this downed quotedcode"

	
	^SoulFactory current makeTemplateQuery
		source: self asString
		variables: variables
		content: content
		block: block
		parsetrees: trees
		queries: queries
		type: type
]
