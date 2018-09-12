method attributes
testMethodContainsSourceComment2
	
	self processQuery:
			' if ?method isMethodInClass: [TestClass5],[?method selector = #commentedMethod3],?method methodContainsSourceComment: [''Smalltalk'']'
		description:
			'The method TestClass5>>commentedMethod3 has a comment "Smalltalk"'.
	self processQuery:
			' if ?method isMethodInClass: [TestClass5],[?method selector = #commentedMethod3],?method methodContainsSourceComment: [''Smalltalk''],?method methodContainsSourceComment: [''is''],?method methodContainsSourceComment: [''fun'']'
		description:
			'The method TestClass5>>commentedMethod3 has the three comments "Smalltalk", "is" and "fun" '.
	self processQuery:
			' if ?method isMethodInClass: [TestClass5],[?method selector = #commentedMethod3],not(?method methodContainsSourceComment: [''Java''])'
		description:
			'The method TestClass5>>commentedMethod3 does not have a comment "Java"'.
	self processQuery:
			' if ?method isMethodInClass: [TestClass5],[?method selector = #commentedMethod0],not(?method methodContainsSourceComment: ?comment)'
		description: 'The method TestClass5>>commentedMethod0 has no comments.'