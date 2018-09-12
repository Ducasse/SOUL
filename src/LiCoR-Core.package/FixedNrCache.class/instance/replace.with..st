adding-removing
replace: oldElement with: newElement
	"find and replace oldElement with newElement (if it exists; otherwise do nothing)"

	
	(self includes: oldElement)
		ifTrue:
			[self
				at: (self keyFor: oldElement)
				put: newElement]