test
valuesThatTestFor
	| values x |
	x := UninitializedTemporary new.
	values := UninitializedTemporary new.
	values testsFor: x.
	^ values