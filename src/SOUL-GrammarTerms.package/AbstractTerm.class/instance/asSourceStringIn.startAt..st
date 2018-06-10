quotedCode
asSourceStringIn: anEnv startAt: anIndex
	"This method is used by the downing process for the QuotedCode. Basically, the parser generates a list of constants and variables when parsing the text inside the QuotedCode. When the quotedcode is downed, it needs to be converted to a string. This is where this method gets invoked"

	
	self halt.
	^self asString