classes
testClassUnderstandsSelector2
	
	self processQuery:
			' if succeeds([Object] classUnderstandsSelector: [#at:put:])'
		description: 'Does object understand #at:put: ?'.
	self processQuery:
			' if succeeds(?class classUnderstandsSelector: [#at:put:])' description:
			'Can we collect all classes understanding #at:put: ?'.
	self processQuery:
			' if succeeds(and(?class classUnderstandsSelector: [#at:put:],?class equals: [OrderedCollection]))'
		description:
			'Is OrderedCollection one of the classes understanding #at:put: ?'.
	self processQuery:
			' if succeeds([TestClass1] classUnderstandsSelector: array)'
		description: 'Direct implementation'.
	self processQuery:
			' if succeeds([SubClass1] classUnderstandsSelector: array)' description:
			'Indirect implementation'