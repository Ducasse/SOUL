printing
prettyPrintOn: aStream scope: id

	aStream withAttributes:(Array with:(TextColor color:(Color r:0 g:0 b:256)) with:(TextEmphasis bold)) do:[aStream write: '{'.].
	super prettyPrintOn: aStream scope: id.
	aStream withAttributes:(Array with:(TextColor color:(Color r:0 g:0 b:256)) with:(TextEmphasis bold)) do:[aStream write: '}'.].