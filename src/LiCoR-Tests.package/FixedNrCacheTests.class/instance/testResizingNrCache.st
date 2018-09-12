fixedNr tests
testResizingNrCache
	"Test the basic adding and overflowing in a FixedNrCache."

	
	| cache |
	cache := FixedNrCache new.
	cache maxSize: 3.
	cache at: #one put: 1.
	cache at: #two put: 2.
	cache at: #three put: 3.
	cache at: #four put: 4.
	cache maxSize: 5.
	self assert: cache currentSize = 3.
	self assert: cache maxSize = 5.
	cache at: #five put: 5.
	cache at: #six put: 6.
	self assert: cache currentSize = 5.
	self assert: cache maxSize = 5.
	cache maxSize: 2.
	self assert: cache currentSize = 2.
	self assert: cache maxSize = 2.
	self assert: (cache includesKey: #five).
	self assert: (cache includesKey: #six)