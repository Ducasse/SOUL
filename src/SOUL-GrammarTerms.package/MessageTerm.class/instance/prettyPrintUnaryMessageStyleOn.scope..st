printing
prettyPrintUnaryMessageStyleOn: aStream scope: id
	
	termsequence terms first prettyPrintOn: aStream scope: #asTerm.
	aStream write: ' '.
	aStream withAttributes:
			(Array
				with: TextColor black
				with: TextEmphasis bold) do:[
	functor message prettyPrintOn: aStream scope: #asTerm.]