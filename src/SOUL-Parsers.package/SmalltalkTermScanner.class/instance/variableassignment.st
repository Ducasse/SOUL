scanning
variableassignment
	
	| token |
	outputStream skip: -2.
	stream skip: -2.
	token := SmaCCToken
		value: outputStream contents
		start: start
		id: (Array with: self nameId).
	outputStream reset.
	matchActions := nil.
	returnMatchBlock value: token