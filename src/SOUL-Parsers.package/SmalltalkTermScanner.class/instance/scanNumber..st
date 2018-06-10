scanning
scanNumber: id
	
	| token number |
	number := Number readFrom: stream.
	outputStream reset.
	token := SmaCCToken
		value: number
		start: start
		id: (Array with: id).
	matchActions := nil.
	returnMatchBlock value: token