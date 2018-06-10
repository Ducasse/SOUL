printing
printForCompileOn: aStream
	
	aStream write: '(' , self class name , ' condition: ('.
	condition printForCompileOn: aStream.
	aStream write: ') conclusion: ('.
	conclusion printForCompileOn: aStream.
	aStream write: '))'.
	self hasComment
		ifTrue:
			[aStream write: ' comment: ' , self comment storeString , '; yourself']