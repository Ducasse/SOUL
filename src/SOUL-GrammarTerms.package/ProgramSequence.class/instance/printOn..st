printing
printOn: aStream
	
	collection
		do: [:currentClause | currentClause printOn: aStream]
		separatedBy:
			[aStream
				write: '.';
				cr]