*SOUL-Kernel
speciesCopyFrom: startIndex to: stopIndex
	"Roel: The regular #copyFrom:to: does not take the type of the 
	receiver into account. For example, copying a part from a 
	symbol results in a String."

	"The default implementation falls back on #copyFrom:to:. 
	Subclasses that have problems (such as Symbol) can override 
	this to return the correct type."

	
	^self copyFrom: startIndex to: stopIndex