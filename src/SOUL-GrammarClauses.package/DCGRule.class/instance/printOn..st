printing
printOn: aStream
	
	self printCommentOn: aStream.
	self printConclusionOn: aStream.
	aStream write: ' --> '.
	condition terms
		do: [:aCondition | self printCondition: aCondition on: aStream]
		separatedBy: [aStream write: ',']