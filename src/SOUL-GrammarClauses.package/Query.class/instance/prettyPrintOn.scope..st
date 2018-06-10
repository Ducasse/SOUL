printing
prettyPrintOn: aStream scope: id
	
	| temp |
	self prettyPrintCommentOn: aStream.
	aStream withAttributes:(Array with:(TextColor red) with:(TextEmphasis bold)) do: [	aStream write: 'if '].
	condition prettyPrintOn: aStream scope: id