*SOUL-Kernel
speciesAppend: aSequnceableCollection
	"Answer a copy of the receiver concatenated with the 
	argument, a SequenceableCollection."

	"Roel: The regular #, does not take the type of the receiver into 
	account. For example, appending symbols results in a String."

	"The default implementation falls back on #,. Subclasses that 
	have problems (such as Symbol) can override this to return the 
	correct type."

	
	^(self , aSequnceableCollection) asSymbol