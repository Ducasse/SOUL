printing
prettyPrintOn: aStream scope: scope
	
	messageTerm prettyPrintOn: aStream scope: scope.
	aStream withAttribute:(TextColor green) do:[
	aStream nextPutAll: ' = '].
	resultTerm prettyPrintOn: aStream scope: scope.
