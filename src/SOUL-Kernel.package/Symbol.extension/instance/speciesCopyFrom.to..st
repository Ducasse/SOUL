*SOUL-Kernel
speciesCopyFrom: startIndex to: stopIndex
	"Roel: The regular #copyFrom:to: does not take the type of the 
	receiver into account, so copying a part from a symbol results 
	in a String. This method makes sure that the result is a Symbol."

	
	^(self copyFrom: startIndex to: stopIndex) asSymbol