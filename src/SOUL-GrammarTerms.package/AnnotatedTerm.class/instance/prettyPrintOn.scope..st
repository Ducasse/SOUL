printing
prettyPrintOn: aStream scope: id
	
	term prettyPrintOn: aStream scope: id.
	aStream
		withAttributes:
			(Array
				with: TextColor red
				with: TextEmphasis bold) do:[
	aStream write: ' : '].
	annotation prettyPrintOn: aStream scope: id