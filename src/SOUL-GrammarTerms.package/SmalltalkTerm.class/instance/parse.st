private
parse
	
	content := SoulFactory current makeSmalltalkTermParser
		parseExpression: source
		onError:
			[:text :pos | self error: 'Parser error: ' , text , 'at: ' , pos asString].
	content parent: self