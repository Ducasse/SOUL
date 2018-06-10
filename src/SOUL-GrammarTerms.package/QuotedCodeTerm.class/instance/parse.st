private
parse
	
	content := source isEmpty
		ifTrue: [#()]
		ifFalse:
			[SoulFactory current makeQuotedCodeParser
				parse: source
				onError:
					[:text :pos | self error: 'Parser error: ' , text , 'at: ' , pos asString]]