access
comment: aComment
	"Empty comments are stored as nil, saves us from having to store an empty string object"

	
	comment := aComment = ''
		ifTrue: [nil]
		ifFalse: [aComment]