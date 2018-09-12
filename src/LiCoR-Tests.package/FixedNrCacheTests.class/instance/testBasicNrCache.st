fixedNr tests
testBasicNrCache
	"Test the basic adding and overflowing in a FixedNrCache."

	
	| cache |
	cache := FixedNrCache new.
	cache maxSize: 3.
	cache at: #one put: 1.
	self assert: cache currentSize = 1.
	self assert: (cache includesKey: #one).
	cache at: #two put: 2.
	self assert: cache currentSize = 2.
	self assert: (cache includesKey: #one).
	self assert: (cache includesKey: #two).
	cache at: #three put: 3.
	self assert: cache currentSize = 3.
	self assert: (cache includesKey: #one).
	self assert: (cache includesKey: #two).
	self assert: (cache includesKey: #three).
	cache at: #four put: 4.
	self assert: cache currentSize = 3.
	self deny: (cache includesKey: #one).
	self assert: (cache includesKey: #two).
	self assert: (cache includesKey: #three).
	self assert: (cache includesKey: #four)