fixedNr tests
testNrCacheRemoval
	
	| cache |
	cache := FixedNrCache new.
	cache maxSize: 3.
	self assert: (cache at: #one ifAbsentPut: 1) = 1.
	self assert: (cache at: #two ifAbsentPut: 2) = 2.
	self assert: (cache at: #three ifAbsentPut: 3) = 3.
	cache removeKey: #two.
	self assert: cache currentSize = 2.
	self assert: (cache includesKey: #one).
	self deny: (cache includesKey: #two).
	self assert: (cache includesKey: #three).
	self assert: (cache at: #four ifAbsentPut: 4) = 4.
	self assert: (cache at: #five ifAbsentPut: 5) = 5.
	self assert: cache currentSize = 3.
	self assert: (cache includesKey: #three).
	self assert: (cache includesKey: #four).
	self assert: (cache includesKey: #five).
	self
		should: [cache remove: 2]
		raise: Error.
	cache remove: 3.
	self assert: cache currentSize = 2.
	self deny: (cache includesKey: #three).
	self assert: (cache includesKey: #four).
	self assert: (cache includesKey: #five).
	cache removeOldest.
	self assert: cache currentSize = 1.
	self deny: (cache includesKey: #four).
	self assert: (cache includesKey: #five).
	cache replace: 5 with: 50.
	self assert: cache currentSize = 1.
	self
		assert:
			(cache
				at: #five
				ifAbsentPut: [0]) = 50