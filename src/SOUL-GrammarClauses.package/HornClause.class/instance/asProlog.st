printing
asProlog
	
	| stream |
	stream := WriteStream on: String new.
	self printAsPrologOn: stream.
	^stream contents