printing
prettyPrintAsKeywordOn: aStream scope: id
	"This method should print the textual representation of the term when it  
	is used as a keyword. This is necessary if uppedobjects are used as  
	keyword"

	
	self prettyPrintOn: aStream scope: id