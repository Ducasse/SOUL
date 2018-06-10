initialize-release
initializeQueries
	
	| parseBlock |
	parseBlock := [:aQueryText | 
	SoulFactory current makeParser
		parse: aQueryText
		onError:
			[:text :pos | self error: 'Parser error: ' , text , 'at: ' , pos asString]].
	continuationQuery := parseBlock value:
			'if  ?Cont@(<?Id , ?Vars, ?Answer ,?Delayed>)'.
	negativeQuery := parseBlock value: 'if ?Cont@(<?Id, ?Vars, ?Delayed>)'