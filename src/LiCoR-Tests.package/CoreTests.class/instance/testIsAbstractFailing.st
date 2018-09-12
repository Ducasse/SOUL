smalltalk method term
testIsAbstractFailing
	"self run: #testIsAbstractFailing"

	"self debug: #testIsAbstractFailing"

	
	| aStMethodTerm |
	aStMethodTerm := self methodForClass: Constant selector: #printOn:.
	self deny: aStMethodTerm isAbstract