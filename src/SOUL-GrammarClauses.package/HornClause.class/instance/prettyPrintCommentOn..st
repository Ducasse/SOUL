printing
prettyPrintCommentOn: aStream
	
	| temp |
	aStream withAttribute:(TextColor gray) do:[
	self printCommentOn: aStream]