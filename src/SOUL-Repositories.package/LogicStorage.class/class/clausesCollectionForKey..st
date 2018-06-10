private - storage
clausesCollectionForKey: key
	
	^self clausesStore
		at: key
		ifAbsentPut: [OrderedCollection new]