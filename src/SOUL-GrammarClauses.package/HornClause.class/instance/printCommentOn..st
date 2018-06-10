printing
printCommentOn: aStream
	
	self hasComment
		ifTrue:
			[aStream
				nextPutAll: '"' , (comment copyReplaceAll: '"' with: '""') , '"';
				cr;
				cr]