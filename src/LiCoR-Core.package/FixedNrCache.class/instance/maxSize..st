private-accessing
maxSize: aNumber
	"set the maximum size to the argument. If necessary, shorten the current 
	elements to accomodate this new maximum size"

	
	maxSize := aNumber.
	[self currentSize > self maxSize] whileTrue: [self removeOldest]