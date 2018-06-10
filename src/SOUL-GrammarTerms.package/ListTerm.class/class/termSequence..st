instance creation
termSequence: aTermSequence
	
	^self new addChildrenInitial: (OrderedCollection with: aTermSequence)