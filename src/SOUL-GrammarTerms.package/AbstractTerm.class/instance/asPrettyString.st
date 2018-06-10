printing
asPrettyString
	
	| aStream |
	aStream := TextStream on: String new.
	self prettyPrintOn: aStream scope: #asClause.
	^aStream contents