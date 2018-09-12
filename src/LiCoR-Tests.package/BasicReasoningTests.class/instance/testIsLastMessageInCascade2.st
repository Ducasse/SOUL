method body
testIsLastMessageInCascade2
	
	self processQuery:
			' if succeeds(and(?Method isMethodWithName: foo inClass: [TestClassRoot],?tree isParseTreeOfMethod: ?Method,?cascade isStChildOf: ?tree,zork isLastMessageInCascade: ?cascade))'
		description: 'This method a single cascade that finishes with zork'.
	self processQuery:
			' if fails(and(?Method isMethodWithName: foo inClass: [TestClassRoot],?tree isParseTreeOfMethod: ?Method,?cascade isStChildOf: ?tree,[#compile:] isLastMessageInCascade: ?cascade))'
		description: 'This method a single cascade that finishes with zork'