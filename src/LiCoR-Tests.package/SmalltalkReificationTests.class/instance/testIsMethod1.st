entities
testIsMethod1
	
	self
		processQuery: ' if ?M isMethod'
		resultsCheck:
			[:results | 
			| mResults |
			mResults := results resultsForVariableNamed: 'M'.
			(mResults
				contains:
					[:sm | 
					sm smalltalkValue fromClass = TestClassRoot
						and: [sm smalltalkValue selector = #doNotOverride]])
				and:
					[mResults
						contains:
							[:sm | 
							sm smalltalkValue fromClass = TestClassRoot class
								and: [sm smalltalkValue selector = #aClassMethod]]]]
		description:
			'Can we find that Soul.TestClassRoot>>#doNotOverride and Soul.TestClassRoot class>>#aClassMethod belong to all methods?'.
	self processQuery: ' if one(?m isMethod),?m isMethod' description:
			'Is each method we can get from the method predicate really a method?'.
	self processQuery:
			' if [(MLI current methodsInClass: TestClassRoot)
	detect: [:m | m selector = #doNotOverride]] isMethod' description:
			'Can we find that Soul.TestClassRoot>>#doNotOverride is indeed a method?'.
	self processQuery:
			' if [(MLI current methodsInClass: TestClassRoot class)
	detect: [:m | m selector = #aClassMethod]] isMethod' description:
			'Can we find that Soul.TestClassRoot class>>#aClassMethod is indeed a method?'.
	self processQuery: ' if fails(foobar isMethod)' description:
			'Are other things not recognized as methods?'