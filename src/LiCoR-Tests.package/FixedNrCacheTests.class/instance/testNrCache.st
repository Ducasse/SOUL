fixedNr tests
testNrCache
	
	| cache |
	cache := FixedNrCache new.
	cache maxSize: 3.
	self assert: (cache at: #one ifAbsentPut: 1) = 1.
	self assert: cache currentSize = 1.
	self assert: (cache includesKey: #one).
	self assert: (cache at: #one ifAbsentPut: 1) = 1.
	self assert: cache currentSize = 1.
	self assert: (cache includesKey: #one).
	self assert: (cache at: #two ifAbsentPut: 2) = 2.
	self assert: cache currentSize = 2.
	self assert: (cache includesKey: #one).
	self assert: (cache includesKey: #two).
	cache clear.
	self assert: cache currentSize = 0.
	self assert: cache maxSize = 3