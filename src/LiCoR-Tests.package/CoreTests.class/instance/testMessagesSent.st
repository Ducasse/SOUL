smalltalk method term
testMessagesSent
	"self run: #testMessagesSent"

	"self debug: #testMessagesSent"

	
	| aStMethodTerm messagesSent |
	aStMethodTerm := self methodForClass: AbstractTerm selector: #printOn:.
	self
		assert:
			aStMethodTerm messages asOrderedCollection
				= (OrderedCollection with: #subclassResponsibility).
	aStMethodTerm := self methodForClass: Constant selector:
			#resolveIn:startAt:.
	messagesSent := OrderedCollection withAll:
			#(#fromClause:toClauses:inEnv:startAt: #normalAddressLookup:multiplicity: #lexicalAddressInEnv:startAt:ifAbsent: #definitionRepository #clauseNotFoundIn:inEnv:startAt: #current #makeResolver).
	self
		assert:
			((aStMethodTerm messages asOrderedCollection)
				removeAll: messagesSent;
				yourself) isEmpty