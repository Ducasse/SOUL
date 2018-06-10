printing
prettyPrintOn: aStream scope: id
	
	self prettyPrintCommentOn: aStream.
	conclusion prettyPrintOn: aStream scope: id.
	aStream withAttributes:(Array with:(TextEmphasis bold) with: (TextColor color:(Color red))) do:[
	aStream
		write: ' if ';
		cr].
	condition prettyPrintOn: aStream scope: id