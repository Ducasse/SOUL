Class {
	#name : #QuotedParseLayer,
	#superclass : #LogicStorage,
	#category : 'SOUL-LogicPrimitives'
}

{ #category : #'template basics' }
QuotedParseLayer >> isListMetaVariableM1 [

?x isListMetaVariable if 
	symbol(?x),['MetaVar*List' match: ?x]
]

{ #category : #'template basics' }
QuotedParseLayer >> isMetaVariableM1 [

?x isMetaVariable if 
	symbol(?x),['MetaVar*' match: ?x]
]

{ #category : #'template basics' }
QuotedParseLayer >> isNewQuotedVariableM1 [

"Create a new quoted variable. This is useful if a new unique quoted variable needs to be created"

?x isNewQuotedVariable if 
	var(?x),?x equals: [('MetaVar' , SoulFactory uniqueName) asSymbol]
]

{ #category : #'template basics' }
QuotedParseLayer >> isQuotedVariableM1 [

"Check if it's a quoted variable."

?x isQuotedVariable if 
	[?x isSymbol],['MetaVar*' match: ?x]
]

{ #category : #'template basics' }
QuotedParseLayer >> parseM3 [

"This predicate is necessary and should not be removed. It is called by the typedquotedcodes to parse their contents"

parse(?type,?string,?tree) if 
	scan(?type,?string,?tokens),?type(?tree,?tokens,<>)
]

{ #category : #'template conversion' }
QuotedParseLayer >> template2queryM2 [

template2query(?template,?query) if 
	parse(stmethod,?template,?tree),tree2query(?tree,?query)
]
