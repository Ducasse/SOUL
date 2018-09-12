smalltalk method term
testIsAbstractSucceeding
	"self run: #testIsAbstract"

	"self debug: #testIsAbstract"

	
	| aStMethodTerm |
	aStMethodTerm := self methodForClass: AbstractTerm selector: #printOn:.
	self assert: aStMethodTerm isAbstract