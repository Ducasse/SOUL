smalltalk -> soul
testSmalltalk2Soul
	
	| symbiosisObject |
	symbiosisObject := TransparentSymbiosisTestClass new.	"Test whether the predicate testValueFor= is invoked and whether the result is correctly returned as an orderedcollection"

	self
		assert:
			(symbiosisObject testValueFor: 1)
				= (OrderedCollection with: 1 with: 11 with: 111).	"Test whether a single value is returned as a FakeSingleItemCollection, meaning it forwards messages to the item"

	self assert: (symbiosisObject testValueFor: 2) + 1 = 3.	"Test whether a single value is returned as a FakeSingleItemCollection, meaning it can respond to some basic Collection protocol messages"

	self assert: (symbiosisObject testValueFor: 2) first + 1 = 3.	"Test whether predicates without a = can be correctly invoked (note: the explicit = true is intentional, in case the message before it returns a non-boolean)"

	self assert: (symbiosisObject supportsTestValueFor: 2) = true.	"Variation on the previous one."

	self assert: (symbiosisObject supportsTestValueFor: 3) = false.	"Tests the use of uninitialized temporaries as arguments (in the TransparentSymbiosisTestClass method that is called here)"

	self
		assert:
			symbiosisObject valuesWithTestValues
				= (OrderedCollection with: 1 with: 1 with: 2 with: 1).	"Tests the sending of a message to an unitialized temporary"

	self
		assert:
			symbiosisObject valuesThatTestFor = (OrderedCollection with: 2 with: 1).	"Tests wether a query that results in just multiple true value returns just true instead of a collection of true"

	self assert: symbiosisObject trueRule = true