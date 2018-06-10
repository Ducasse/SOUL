printing
printOn: aStream
	
	aStream write: '['.
	variableArray
		do: [:value | value printOn: aStream]
		separatedBy: [aStream cr].
	aStream write: ']'