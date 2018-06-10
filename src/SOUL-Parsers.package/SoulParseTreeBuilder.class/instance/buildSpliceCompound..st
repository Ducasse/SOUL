building SmalltalkTerm/QuotedCode
buildSpliceCompound: aString
	
	| result |
	result := SoulFactory current makeParser
		parse: (aString allButFirst: 1)
		onError: [:ex :id | self error: ex , ' at ' , id asString].
	^result clauses first conclusion	"asApplyCompound"