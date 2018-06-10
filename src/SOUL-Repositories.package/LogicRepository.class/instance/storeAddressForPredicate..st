private
storeAddressForPredicate: predicate
	"sets and returns the address for this predicate"

	
	^addressForPredicate
		at: predicate
		ifAbsentPut: [self nextAddress]