Extension { #name : #Character }

{ #category : #'*SOUL-Kernel' }
Character >> isBlank [
	"Relied upon but not provided by SmaCCScanner, also provided by RBCodeHighlighting."

	"space or tab"

	
	^self == $  or: [self == $	]
]
