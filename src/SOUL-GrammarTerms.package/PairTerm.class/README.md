collect
	
	|newCollection|
	newCollection := OrderedCollection new.
	self listDo: [:elt | newCollection add: elt ].
	^newCollection