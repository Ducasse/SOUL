initialize
source: aString
	
	source := aString.
	self parse.
	self parseVariables.
	self constructBlock