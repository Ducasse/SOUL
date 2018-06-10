printing
asPrettyString
	
	| aStream |
	aStream := TextStream on: Text new.
	self prettyPrintOn: aStream scope: #asClause.
	^aStream contents