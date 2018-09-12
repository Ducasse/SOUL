smalltalk method term
testReferencesClass
	"self run: #testReferencesClass"

	"self debug: #testReferencesClass"

	
	| aStMethodTerm |
	aStMethodTerm := self methodForClass: Constant selector:
			#resolveIn:startAt:.
	self assert: (aStMethodTerm referencesClass: SoulFactory).
	self deny: (aStMethodTerm referencesClass: Object)