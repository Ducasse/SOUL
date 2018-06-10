access
push: anElement
	
	self at: currentIndex put: anElement.
	currentIndex := currentIndex + 1