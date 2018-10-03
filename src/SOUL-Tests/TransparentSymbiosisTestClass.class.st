Class {
	#name : #TransparentSymbiosisTestClass,
	#superclass : #SymbiosisClass,
	#category : 'SOUL-Tests'
}

{ #category : #test }
TransparentSymbiosisTestClass >> valuesThatTestFor [
	| values x |
	x := UninitializedTemporary new.
	values := UninitializedTemporary new.
	values testsFor: x.
	^ values
]

{ #category : #test }
TransparentSymbiosisTestClass >> valuesWithTestValues [
	| values |
	values := UninitializedTemporary new.
	self testValueFor: values.
	^ values
]
