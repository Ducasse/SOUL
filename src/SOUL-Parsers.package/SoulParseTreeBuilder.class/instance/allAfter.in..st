private
allAfter: anObject in: aCollection
	
	| startIndex |
	startIndex := aCollection indexOf: anObject.
	^aCollection
		copyFrom: startIndex + 1
		to: aCollection size