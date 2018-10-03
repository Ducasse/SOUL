Class {
	#name : #FixedNrCacheTests,
	#superclass : #TestCase,
	#category : 'LiCoR-Tests'
}

{ #category : #'fixedNr tests' }
FixedNrCacheTests >> testBasicNrCache [
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
]

{ #category : #'fixedNr tests' }
FixedNrCacheTests >> testNrCache [
	
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
]

{ #category : #'fixedNr tests' }
FixedNrCacheTests >> testNrCacheRemoval [
	
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
]

{ #category : #'fixedNr tests' }
FixedNrCacheTests >> testResizingNrCache [
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
]
