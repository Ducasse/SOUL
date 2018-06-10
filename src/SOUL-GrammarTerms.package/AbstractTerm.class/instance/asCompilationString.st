converting
asCompilationString
	
	| tempStream |
	tempStream := WriteStream on: String new.
	self printForCompileOn: tempStream.
	^tempStream contents