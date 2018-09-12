smalltalk method term
testClassReferences
	"self run: #testClassReferences"

	"self debug: #testClassReferences"

	
	| aStMethodTerm |
	Test := Array.
	aStMethodTerm := self
		methodForClass: self class
		selector: #zork.
	self
		assert:
			aStMethodTerm classesReferenced asOrderedCollection
				= (OrderedCollection with: SoulFactory with: Array).
	aStMethodTerm := self methodForClass: Constant selector:
			#resolveIn:startAt:.
	self
		assert:
			aStMethodTerm classesReferenced asOrderedCollection
				= (OrderedCollection with: SoulFactory)