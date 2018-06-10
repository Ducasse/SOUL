scanning
compound
	
	| token |
	self scanUpTo: $( ignore: $@.
	self scanUpTo: $) ignore: $(.
	token := SmaCCToken
		value: outputStream contents
		start: start
		id: (Array with: self compoundId).
	matchActions := nil.
	returnMatchBlock value: token