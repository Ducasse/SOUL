scanning
comment
	
	| newComment |
	newComment := outputStream contents copyReplaceAll: '""' with: '"'.
	newComment := newComment size > 2
		ifTrue:
			[newComment
				copyFrom: 2
				to: newComment size - 1]
		ifFalse: [''].
	commentText := (commentText
		ifNil: ['']
		ifNotNil:
			[commentText , (String with: Character cr) , (String with: Character cr)])
		, newComment.
	^super comment