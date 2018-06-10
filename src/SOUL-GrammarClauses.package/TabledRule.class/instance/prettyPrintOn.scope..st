printing
prettyPrintOn: aStream scope: id
	
	self prettyPrintCommentOn: aStream.
	aStream withAttributes:(Array with: TextEmphasis italic with:(TextColor blue)) do:[
		aStream write: 'tabled '.
	].
	^super prettyPrintOn: aStream scope: id