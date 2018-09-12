private
methodForClass: aClass selector: aSymbol
	"Return a method reification. Makes sure that this works for the representation with a SmalltalkMethod and for the CompiledMethod."

	
	^(MLI current methodsInClass: aClass) detect: [:m | m selector = aSymbol]