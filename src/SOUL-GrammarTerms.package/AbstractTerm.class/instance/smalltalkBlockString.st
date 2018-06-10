converting
smalltalkBlockString
	"This method is used by the building process for the SmalltalkTerms. Basically, the parser generates a list of constants and variables when parsing the 	code inside the SmalltalkTerm. When the code is handed to the Smalltalk Compiler, the code needs to be printed out again. This is where this method 	gets invoked"

	
	^self asString