scanning
stterm
	
	| token |
	self scanUpTo: $] ignore: $[.
	token := SmaCCToken
		value: outputStream contents
		start: start
		id: (Array with: self sttermId).
	matchActions := nil.
	returnMatchBlock value: token