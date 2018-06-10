private
makeNative: aString if: aClauseClass
	
	| conclusion resultClause temp |
	"Production of native clauses"

	conclusion := (SoulFactory current makeParser
		parse: aString
		onError:
			[:text :pos | self error: 'Parser error: ' , text , 'at: ' , pos asString])
		clauses first conclusion.
	temp := OrderedCollection new.
	temp add: (aClauseClass newWith: conclusion termSequence).
	resultClause := SoulFactory current makeRule
		condition:
			(SoulFactory current makeTermSequence terms: temp containsCut: false)
		conclusion: conclusion.
	^resultClause