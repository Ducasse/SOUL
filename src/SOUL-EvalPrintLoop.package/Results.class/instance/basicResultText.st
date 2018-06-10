printing
basicResultText
	
	| stream |
	stream := WriteStream on: String new.
	self printBasicInformationOn: stream.
	^stream contents