smalltalk method term
testAllSourceComments
	
	| wrappedMethod |
	wrappedMethod := self methodForClass: TestClass5 selector:
			#commentedMethod0.
	self assert: wrappedMethod allSourceComments size = 0.
	wrappedMethod := self methodForClass: TestClass5 selector:
			#commentedMethod1.
	self assert: wrappedMethod allSourceComments size = 1.
	self
		assert:
			wrappedMethod allSourceComments first = 'This method has one comment'.
	wrappedMethod := self methodForClass: TestClass5 selector:
			#commentedMethod3.
	self assert: wrappedMethod allSourceComments size = 3.
	self assert: (wrappedMethod allSourceComments includes: 'fun').
	self assert: (wrappedMethod allSourceComments includes: 'Smalltalk').
	self assert: (wrappedMethod allSourceComments includes: 'is')