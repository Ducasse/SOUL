public-access
size
	"Returns the number of results"

	
	^results isEmpty
		ifTrue: [0]
		ifFalse: [results associations first value size]