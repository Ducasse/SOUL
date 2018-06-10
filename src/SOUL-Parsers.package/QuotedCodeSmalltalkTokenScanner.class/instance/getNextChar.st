scanner directives
getNextChar
	
	hereChar := source next.
	hereChar == nil ifFalse: [buffer nextPut: hereChar]