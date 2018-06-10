initialize-release
initializeFrom: aStack
	
	currentIndex := aStack size + 1.
	(1 to: currentIndex - 1)
		do:
			[:i | 
			self
				at: i
				put: (aStack at: i)]