printing
printOn: aStream
	
	aStream
		print: self class;
		nextPutAll: ' ['.
	(1 to: currentIndex - 1)
		do: [:index | (self at: index) printOn: aStream]
		separatedBy: [aStream nextPutAll: ', '].
	aStream nextPut: $]