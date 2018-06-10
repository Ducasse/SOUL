scanning
quoted
	
	| token |
	self scanUpTo: $} ignore: ${.
	token := SmaCCToken
		value: outputStream contents
		start: start
		id: (Array with: self quotedId).
	matchActions := nil.
	returnMatchBlock value: token