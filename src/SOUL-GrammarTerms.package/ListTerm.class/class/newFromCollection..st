instance creation
newFromCollection: aCollection
	
	^self new
		addChildrenInitial:
			(OrderedCollection
				with: (TermSequence terms: (aCollection asOrderedCollection collect: [:e | e soulUp])))