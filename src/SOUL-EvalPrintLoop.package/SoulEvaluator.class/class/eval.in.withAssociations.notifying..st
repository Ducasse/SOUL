instance creation
eval: aQueryText in: aRepository withAssociations: aCollection notifying: aTextController
	
	| parser query |
	self configureFactory.
	parser := SoulFactory current makeParser.
	aTextController isNil
		ifTrue:
			[query := parser
				parse: aQueryText
				onError:
					[:text :pos | self error: 'Parser error: ' , text , 'at: ' , pos asString]]
		ifFalse:
			[query := parser
				parse: aQueryText
				onError:
					[:text :pos | 
					aTextController
						insertAndSelect: '<-' , text
						at: pos.
					aTextController activate.
					^EmptyEvaluator new]].
	query species == SoulFactory current makeQuery
		ifFalse:
			[Error
				raiseSignal:
					'Evaluator input is not a query (missing ''if'' ?): ' , aQueryText].
	^self evalQuery: query in: aRepository withAssociations: aCollection