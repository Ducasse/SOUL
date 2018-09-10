test
valuesWithTestValues
	| values |
	values := UninitializedTemporary new.
	self testValueFor: values.
	^ values