private - storage
storeClausesWithPredicateKey: key
	
	| source selector |
	self doingInternalStorage: true.
	[(self clausesCollectionForKey: key) isEmpty
		ifTrue: [self deleteStorageOfClausesWithPredicateKey: key]
		ifFalse:
			[selector := self selectorForPredicateKey: key.
			source := selector , (self printClausesWithKey: key).
			self compile: source.
			self selectorToPredicateKeyMapping at: selector put: key.
			self notifyImplementationChange]]
		ensure: [self doingInternalStorage: false]