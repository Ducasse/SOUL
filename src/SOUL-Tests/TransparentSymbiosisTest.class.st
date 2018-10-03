Class {
	#name : #TransparentSymbiosisTest,
	#superclass : #LogicTests,
	#instVars : [
		'oldFactory'
	],
	#category : 'SOUL-Tests'
}

{ #category : #Running }
TransparentSymbiosisTest >> setUp [
	
	oldFactory := SoulFactory current.
	SymbiosisFactory installSymbiosisFactory
]

{ #category : #Running }
TransparentSymbiosisTest >> tearDown [
	
	SymbiosisFactory revertTo: oldFactory
]

{ #category : #'smalltalk -> soul' }
TransparentSymbiosisTest >> testCorrectFailure [
	"Tests whether it doesn't get into an endless loop when neither rule nor method exists. Placed seperately just in case it *does* loop so you know what's wrong."

	
	self
		should:
			[TransparentSymbiosisTestClass new supercalifragilisticexpialidocious]
		raise: Exception
]

{ #category : #'smalltalk -> soul' }
TransparentSymbiosisTest >> testSmalltalk2Soul [
	
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
]

{ #category : #'soul -> smalltalk' }
TransparentSymbiosisTest >> testSoul2Smalltalk [
	"These tests aren't very good because they still depend on the old symbiosis mechanism with the brackets .... it should perhaps become possible in the future to specify class names in SOUL directly without having to use the brackets"

	
	self processQuery: ' if [Array new] isEmpty' description:
			'Tests if a MessageTerm is correctly translated to a message'.
	self processQuery:
			' if [OrderedCollection new] asString = [''an OrderedCollection()'']'
		description:
			'Tests if a ResultMessageTerm without arguments is correctly translated to a message'.
	self processQuery: ' if [Array] with: 1 with: 2 = ?o,?o includes: 1'
		description:
			'Tests if a ResultMessageTerm with arguments is correctly translated to a message'.
	self processQuery:
			' if equals(?x,[OrderedCollection with: 1 with: 2 with: 3]),findall(?r,?x yourself = ?r,<1,2,3>)'
		description:
			'Tests wether results of messages to Smalltalk that are contained in an OrderedCollection are unwrapped and returned as seperate results.'.
	self processQuery:
			' if equals(?x,[OrderedCollection with: 1 with: 2 with: 3]),?x yourself = ?r,equals(?r,3),findall(?s,?x yourself = ?s,<1,2,3>)'
		description:
			'Tests wether the collections returned from messages to Smalltalk are not modified due to backtracking.'
]
