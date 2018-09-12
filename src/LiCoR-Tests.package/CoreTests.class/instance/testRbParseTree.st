smalltalk method term
testRbParseTree
	
	| aStMethodTerm |
	aStMethodTerm := self methodForClass: Constant selector:
			#resolveIn:startAt:.
	self assert: (aStMethodTerm rbParseTree isKindOf: RBMethodNode)