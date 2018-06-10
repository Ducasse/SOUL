DCG
convertDirectRuleCalls: aBody
	"Process the direct calls to logic rules. They are embedded in quotedcode terms... a little bit of a mis-usage, but it works ;-)"

	
	| newTerms |
	newTerms := aBody terms
		collect:
			[:aClause | 
			(aClause isKindOf: QuotedCodeTerm)
				ifTrue:
					[SoulFactory current makeParser
						parse: aClause source
						onError: [:a :b | self error: 'Something went terribly wrong!']]
				ifFalse: [aClause]].
	aBody terms: newTerms